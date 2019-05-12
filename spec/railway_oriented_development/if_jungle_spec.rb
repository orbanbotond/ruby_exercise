require 'spec_helper'

add = ->(params:) do
  return { validation: 'must be a real number' } if params.any?{|x|x.infinite?}

  result = params.reduce(0) { |acc, x| acc + x }
  return { operation_result: result }
end

multiply = ->(params:) do
  if params.all?{|x|x.finite?}
    result = params.reduce(1) { |acc, x| acc * x }
    return { operation_result: result }
  else
    return { validation: 'must be a real number' }
  end
end

complex = ->(params:) do
  result = multiply.call(params: params[-2..-1])
  if(result[:operation_result])
    return add.call(params: [result[:operation_result], params[0]])
  else
    return result
  end
end

describe 'If Jungle' do
  context 'add' do
    subject { add.call params: params }
    let(:params) { [2,3,4] }

    context 'negative cases' do
      context 'params infinite' do
        let(:params) { [(1.0/0.0), 2] }

        specify 'Be a failure with a proper error message' do
          expect(subject[:validation]).to eq 'must be a real number'
        end
      end
    end

    context 'positive cases' do
      specify 'Be a success with the proper correct output' do
        expect(subject[:operation_result]).to eq(params.reduce(0) { |acc, x| acc + x })
      end
    end
  end

  context 'multiply' do
    subject { multiply.call params: params }
    let(:params) { [2,3,4] }

    context 'negative cases' do
      context 'params infinite' do
        let(:params) { [(1.0/0.0), 2] }

        specify 'Be a failure with a proper error message' do
          expect(subject[:validation]).to eq 'must be a real number'
        end
      end
    end

    context 'postitive cases' do
      specify 'Be a success with the proper correct output' do
        expect(subject[:operation_result]).to eq(params.reduce(1) { |acc, x| acc * x })
      end
    end
  end

  context 'nesting' do
    subject { complex.call params: params }
    let(:params) { [2,3,4] }

    context 'negative cases' do
      context 'params infinite' do
        let(:params) { [(1.0/0.0), 2, 4] }

        specify 'Be a failure with a proper error message' do
          expect(subject[:validation]).to eq 'must be a real number'
        end
      end

      context 'params infinite 2' do
        let(:params) { [2, (1.0/0.0), 4] }

        specify 'Be a failure with a proper error message' do
          expect(subject[:validation]).to eq 'must be a real number'
        end
      end
    end

    context 'postitive cases' do
      specify 'Be a success with the proper correct output' do
        expect(subject[:operation_result]).to eq(params[0] + params[1] * params[2])
      end
    end
  end
end

