require 'spec_helper'

class Add
  include Dry::Transaction

  step :validate
  step :add

  private

  def validate(input)
    return Failure('must be a real number') unless input.all?{|x|x.finite?}

    Success(input)
  end

  def add(input)
    ret = input.reduce(0) { |acc, x| acc + x }

    Success(ret)
  end
end

class Multiply
  include Dry::Transaction

  step :validate
  step :multiply

  private

  def validate(input)
    return Failure('must be a real number') unless input.all?{|x|x.finite?}

    Success(input)
  end

  def multiply(input)
    ret = input.reduce(1) { |acc, x| acc * x }

    Success(ret)
  end
end

class ComplexOperation
  include Dry::Transaction

  step :evaluate

  private

  def evaluate(input)
    partialValues = [Multiply.new.call([input[1], input[2]])]
    failures = partialValues.select{|x|x.failure?}

    return failures.first if failures.present?

    Add.new.call( [input[0], partialValues.map{|x|x.value!}].flatten)
  end
end


describe 'DryTransactions' do
  context 'add' do
    subject { Add.new.call params }
    let(:params) { [2,3,4] }

    context 'negative cases' do
      context 'params infinite' do
        let(:params) { [(1.0/0.0), 2] }

        specify 'Be a failure with a proper error message' do
          expect(subject).to be_failure
          expect(subject.failure).to eq 'must be a real number'
        end
      end
    end

    context 'postitive cases' do
      specify 'Be a success with the proper correct output' do
        expect(subject).to be_success
        expect(subject.value!).to eq(params.reduce(0) { |acc, x| acc + x })
      end
    end
  end

  context 'multiply' do
    subject { Multiply.new.call params }
    let(:params) { [2,3,4] }

    context 'negative cases' do
      context 'params infinite' do
        let(:params) { [(1.0/0.0), 2] }

        specify 'Be a failure with a proper error message' do
          expect(subject).to be_failure
          expect(subject.failure).to eq 'must be a real number'
        end
      end
    end

    context 'postitive cases' do
      specify 'Be a success with the proper correct output' do
        expect(subject).to be_success
        expect(subject.value!).to eq(params.reduce(1) { |acc, x| acc * x })
      end
    end
  end

  context 'nesting' do
    subject { ComplexOperation.new.call params }
    let(:params) { [2,3,4] }

    context 'negative cases' do
      context 'params infinite' do
        let(:params) { [(1.0/0.0), 2, 4] }

        specify 'Be a failure with a proper error message' do
          expect(subject).to be_failure
          expect(subject.failure).to eq 'must be a real number'
        end
      end

      context 'params infinite 2' do
        let(:params) { [2, (1.0/0.0), 4] }

        specify 'Be a failure with a proper error message' do
          expect(subject).to be_failure
          expect(subject.failure).to eq 'must be a real number'
        end
      end
    end

    context 'postitive cases' do
      specify 'Be a success with the proper correct output' do
        expect(subject).to be_success
        expect(subject.value!).to eq(params[0] + params[1] * params[2])
      end
    end
  end
end
