require 'spec_helper'

module DryTransactions
  class Add
    include Dry::Transaction

    step :validate
    step :add

    private

    def validate(input)
      return Failure('must be a real number') unless input[:params].all?{|x|x.finite?}

      Success(input)
    end

    def add(input)
      ret = input[:params].reduce(0) { |acc, x| acc + x }

      Success(ret)
    end
  end

  class Multiply
    include Dry::Transaction

    step :validate
    step :multiply

    private

    def validate(input)
      return Failure('must be a real number') unless input[:params].all?{|x|x.finite?}

      Success(input)
    end

    def multiply(input)
      ret = input[:params].reduce(1) { |acc, x| acc * x }

      Success(ret)
    end
  end

  class ComplexOperation
    include Dry::Transaction

    step :multiply
    step :linear_computation

    private

    def multiply(input)
      partialValue = Multiply.new.call(params: [input[:params][1], input[:params][2]])

      partialValue.bind do |value|
        Success(input.merge(multiplication_result: partialValue.value!))
      end
    end

    def linear_computation(input)
      Add.new.call( params: [input[:params][0], input[:multiplication_result]])
    end
  end
end

describe 'DryTransactions' do
  context 'add' do
    subject { DryTransactions::Add.new.call params }
    let(:params) { {params:[2,3,4]} }

    context 'negative cases' do
      context 'params infinite' do
        let(:params) { {params:[(1.0/0.0), 2]} }

        specify 'Be a failure with a proper error message' do
          expect(subject).to be_failure
          expect(subject.failure).to eq 'must be a real number'
        end
      end
    end

    context 'postitive cases' do
      specify 'Be a success with the proper correct output' do
        expect(subject).to be_success
        expect(subject.value!).to eq(params[:params].reduce(0) { |acc, x| acc + x })
      end
    end
  end

  context 'multiply' do
    subject { DryTransactions::Multiply.new.call params }
    let(:params) { {params: [2,3,4]} }

    context 'negative cases' do
      context 'params infinite' do
        let(:params) { {params: [(1.0/0.0), 2]} }

        specify 'Be a failure with a proper error message' do
          expect(subject).to be_failure
          expect(subject.failure).to eq 'must be a real number'
        end
      end
    end

    context 'postitive cases' do
      specify 'Be a success with the proper correct output' do
        expect(subject).to be_success
        expect(subject.value!).to eq(params[:params].reduce(1) { |acc, x| acc * x })
      end
    end
  end

  context 'nesting' do
    subject { DryTransactions::ComplexOperation.new.call params }
    let(:params) { {params:[2,3,4]} }

    context 'negative cases' do
      context 'params infinite' do
        let(:params) { {params:[(1.0/0.0), 2, 4]} }

        specify 'Be a failure with a proper error message' do
          expect(subject).to be_failure
          expect(subject.failure).to eq 'must be a real number'
        end
      end

      context 'params infinite 2' do
        let(:params) { {params:[2, (1.0/0.0), 4]} }

        specify 'Be a failure with a proper error message' do
          expect(subject).to be_failure
          expect(subject.failure).to eq 'must be a real number'
        end
      end
    end

    context 'positive cases' do
      specify 'Be a success with the proper correct output' do
        expect(subject).to be_success
        args = params[:params]
        expect(subject.value!).to eq(args[0] + args[1] * args[2])
      end
    end
  end
end
