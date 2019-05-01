require 'spec_helper'

module Interactors
  class Add
    include Interactor

    def call
      validate(context.arguments)
      context.result = add(context.arguments)
    end

    private

    def validate(input)
      context.fail!(error: 'must be a real number') unless input.all?{|x|x.finite?}
    end

    def add(input)
      ret = input.reduce(0) { |acc, x| acc + x }
    end
  end

  class Multiply
    include Interactor

    def call
      validate(context.arguments)
      context.result = multiply(context.arguments)
    end

    private

    def validate(input)
      context.fail!(error: 'must be a real number') unless input.all?{|x|x.finite?}
    end

    def multiply(input)
      ret = input.reduce(1) { |acc, x| acc * x }
    end
  end

  class ComplexOperation
    include Interactor

    def call
      input = context.arguments
      partialValues = [Multiply.call(arguments: [input[1], input[2]])]
      failures = partialValues.select{|x|x.failure?}

      context.fail!(error: failures.first.error) if failures.present?

      addition = Add.call( arguments: [input[0], partialValues.map{|x|x.result}].flatten)

      if addition.success?
        context.result = addition.result
      else
        context.fail!(error: addition.error)
      end
    end
  end
end

describe 'DryTransactions' do
  context 'add' do
    subject { Interactors::Add.call(arguments: params) }
    let(:params) { [2,3,4] }

    context 'negative cases' do
      context 'params infinite' do
        let(:params) { [(1.0/0.0), 2] }

        specify 'Be a failure with a proper error message' do
          expect(subject).to be_failure
          expect(subject.error).to eq 'must be a real number'
        end
      end
    end

    context 'postitive cases' do
      specify 'Be a success with the proper correct output' do
        expect(subject).to be_success
        expect(subject.result).to eq(params.reduce(0) { |acc, x| acc + x })
      end
    end
  end

  context 'multiply' do
    subject { Interactors::Multiply.call(arguments: params) }
    let(:params) { [2,3,4] }

    context 'negative cases' do
      context 'params infinite' do
        let(:params) { [(1.0/0.0), 2] }

        specify 'Be a failure with a proper error message' do
          expect(subject).to be_failure
          expect(subject.error).to eq 'must be a real number'
        end
      end
    end

    context 'postitive cases' do
      specify 'Be a success with the proper correct output' do
        expect(subject).to be_success
        expect(subject.result).to eq(params.reduce(1) { |acc, x| acc * x })
      end
    end
  end

  context 'nesting' do
    subject { Interactors::ComplexOperation.call(arguments: params) }
    let(:params) { [2,3,4] }

    context 'negative cases' do
      context 'params infinite' do
        let(:params) { [(1.0/0.0), 2, 4] }

        specify 'Be a failure with a proper error message' do
          expect(subject).to be_failure
          expect(subject.error).to eq 'must be a real number'
        end
      end

      context 'params infinite 2' do
        let(:params) { [2, (1.0/0.0), 4] }

        specify 'Be a failure with a proper error message' do
          expect(subject).to be_failure
          expect(subject.error).to eq 'must be a real number'
        end
      end
    end

    context 'postitive cases' do
      specify 'Be a success with the proper correct output' do
        expect(subject).to be_success
        expect(subject.result).to eq(params[0] + params[1] * params[2])
      end
    end
  end
end
