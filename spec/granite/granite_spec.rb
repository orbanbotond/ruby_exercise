require 'sqlite3'
require 'active_record'

require 'spec_helper'

require 'granite/rspec/satisfy_preconditions'

# gem 'i18n'
# Then configure I18n with some translations, and a default locale:

I18n.load_path << Dir[File.expand_path("config/locales") + "/*.yml"]

ActiveRecord::Base.establish_connection(
  :adapter => "sqlite3",
  :database  => ":memory:"
)

ActiveRecord::Schema.define do
  create_table "users" do |table|
    table.datetime "created_at", null: false
    table.string "first_name"
    table.string "last_name"
  end
end

describe 'Granite' do
  before do
    create_temporary_class 'User', ActiveRecord::Base do
    end

    create_temporary_class 'BusinessAction', Granite::Action do
      allow_if { performer.present? }

      subject :user

      precondition do
        decline_with(:not_baptizable) unless subject.new_record?
      end

      attribute :first_name, String
      attribute :last_name, String
      attribute :additional_attribute, String

      validates :first_name, presence: true
      validates :last_name, presence: true
      validates :additional_attribute, absence: true, on: :new

      private def execute_perform!(*)
        subject.first_name = first_name
        subject.last_name = last_name
        subject.save
      end
    end
  end

  subject { BusinessAction.new(ba_subject, params) }

  let(:ba_subject) { User.new }
  let(:params) { { additional_attribute: "yeijj", first_name: "Botond", last_name: "Orban" } }

  context 'preconditions' do
    context 'positive cases' do
      it { is_expected.to satisfy_preconditions }
    end

    context 'negative cases' do
      let(:ba_subject) { User.create }
      let(:params) { super().except :last_name }
      it { is_expected.not_to satisfy_preconditions.with_message 'yeiyy' }
    end
  end

  context 'attributes' do
    subject { lambda { BusinessAction.new(ba_subject, params) } }

    # The uneclared attribute will be ignored.
    let(:params) { super().merge( unexistent_attribute_on_the_business_action: :a )}

    context 'positive cases' do
      it { should_not raise_exception }
    end
  end

  context 'validations' do
    context 'default validation' do
      subject { BusinessAction.new(ba_subject, params) }

      context 'positive cases' do
        it { is_expected.to be_valid }
      end

      context 'negative cases' do
        let(:params) { super().except(:first_name) }
        
        it { is_expected.to_not be_valid }

        context 'error messages' do
          subject do
            super().valid?
            super().errors
          end

          specify 'contains the proper error msg' do
            expect(subject).to include(:first_name)
            expect(subject).not_to include(:last_name)
            expect(subject).not_to include(:additional_attribute)
          end
        end
      end
    end

    context 'context validation' do
      subject { BusinessAction.new(ba_subject, params).valid?(:new) }

      context 'positive case' do
        let(:params) { super().except :additional_attribute }
        it { is_expected.to eq true }
      end

      context 'negative case' do
        it { is_expected.to eq false }
      end
    end
  end

  context 'history' do
    # ????
  end

  context 'perform' do
    context 'positive cases' do
      subject { lambda { BusinessAction.as(:anybody).new(ba_subject, params).perform! } }

      it { should_not raise_exception }
      it { is_expected.to be_truthy }

      specify do
        subject.call
        expect(ba_subject.reload).to be_persisted
        expect(ba_subject.reload.first_name).to eq params[:first_name]
        expect(ba_subject.reload.last_name).to eq params[:last_name]
      end
    end

    context 'negative cases' do
      # There is no performer so it should not bew allowed to be executed.
      subject { lambda { BusinessAction.new(ba_subject, params).perform! } }

      it { should raise_exception }
    end
  end

  context 'exceptions handling' do
  end

  context 'complete lifecycle' do
    # perform!(context: :user)
  end
end
