require 'rubygems'
require 'bundler/setup'

require 'active_model'
require 'debug'

# A tiny Result primitive you can reuse across services.
class Result
  # value is rather params
  attr_reader :value, :error

  def initialize(ok:, value: nil, error: nil)
    @ok = ok
    @value = value
    @error = error
  end

  def self.ok(value = nil) = new(ok: true, value: value)
  def self.fail(error)     = new(ok: false, error: error)

  def ok? = @ok

  # Railway switch: only continues if ok?
  def then
    return self unless ok?
    yield(value)
  rescue => e
    Result.fail(code: :exception, message: e.message)
  end
end

class CreateUser
  def call(params)
    Result.ok(params)
      .then { |p| validate(p) }
      .then { |p| normalize(p) }
      .then { |p| persist(p) }
  end

  private

  def validate(p)
    email = p[:email].to_s.strip
    return Result.fail(code: :invalid_email, message: "email is required") if email.empty?
    return Result.fail(code: :invalid_email, message: "email is too long") if email.length > 255

    Result.ok(p.merge(email: email))
  end

  def normalize(p)
    Result.ok(p.merge(email: p[:email].downcase))
  end

  def persist(p)
    # In a real app: User.create!(...)
    user = { id: 123, email: p[:email] }
    Result.ok(user)
  end
end

describe 'First version' do
  subject { CreateUser.new.call(params) }

  let(:params) { {email: " TEST@Example.com "} }

  it { is_expected.to be_ok }

  context 'failure?' do
    let(:params) { {email: ""} }

    it { is_expected.to_not be_ok }

    it 'contains error' do
      expect(subject.error).to include(code: :invalid_email, message: "email is required")
    end
  end
end

class Result
  def self.fail(code:, message:, details: nil, step: nil)
    new(ok: false, error: { code: code, message: message, details: details, step: step })
  end

  def step(name)
    return self if ok?

    Result.fail(**error, step: error[:step] || name)
  end
end

class CreateUser2 < CreateUser
  def call(params)
    Result.ok(params)
      .then { |p| validate(p).step(:validate) }
      .then { |p| normalize(p).step(:normalize) }
      .then { |p| persist(p).step(:persist) }
  end
end

describe 'improved version' do
  context 'ok?' do
    subject { CreateUser2.new.call(email: " TEST@Example.com ").ok? }

    it { is_expected.to be(true) }
  end

  context 'failure?' do
    subject { CreateUser2.new.call(email: "") }

    it { is_expected.to_not be(:ok?) }

    it 'contains error' do
      expect(subject.error).to include(step: :validate, code: :invalid_email, message: "email is required")
    end
  end
end

class User
  include ActiveModel::API

  attr_accessor :name, :email
  validates :name, :email, presence: true

  def save
    valid?
  end
end

module Users
end

class ResultCompact < Result
  def self.fail(code:, message:, details: nil, step: nil)
    new(ok: false, error: { code: code, message: message, details: details, step: step })
  end

  def then(step_name)
    return self unless ok?

    result = yield(value)
    return result if result.ok?

    ResultCompact.fail(**result.error, step: result.error[:step] || step_name)
  rescue => e
    ResultCompact.fail(code: :exception, message: e.message)
  end
end

class Users::CreateUser
  def call(params, current_actor: nil)
    ResultCompact.ok(params)
      .then(:coerce)    { |p| coerce(p) }
      .then(:authorize) { |p| authorize(p, current_actor) }
      .then(:create)    { |p| create_in_transaction(p) }
  end

  private

  def coerce(p)
    email = p[:email].to_s.strip.downcase
    ResultCompact.ok(p.merge(email: email))
  end

  def authorize(p, current_actor)
    return ResultCompact.ok(p) if current_actor.present?

    ResultCompact.fail(code: :forbidden, message: "not authorized")
  end

  def create_in_transaction(p)
    # ActiveRecord::Base.transaction do
      user = User.new(email: p[:email], name: p[:name])

      if user.save
        ResultCompact.ok(user)
      else
        # Rails validations -> structured failure
        return ResultCompact.fail(
          code: :validation_failed,
          message: "User is invalid",
          details: user.errors.to_hash(true)
        )
      end
    # end
  # rescue ActiveRecord::RecordNotUnique
  #   ResultCompact.fail(code: :conflict, message: "email already exists")
  end
end

describe 'rails version' do
  let(:current_user) { :me }

  context 'ok?' do
    subject { Users::CreateUser.new.call({email: 'boti@gmail.com', name: 'Botond'}, current_actor: current_user) }

    it { is_expected.to be_ok }
  end

  context 'failure?' do
    subject { Users::CreateUser.new.call({email: 'boti@gmail.com', name: nil}, current_actor: current_user) }

    it { is_expected.to_not be_ok }

    it 'contains error' do
      expect(subject.error).to include(step: :create, code: :validation_failed, message: "User is invalid", details: {name: ["Name can't be blank"]})
    end
  end
end
