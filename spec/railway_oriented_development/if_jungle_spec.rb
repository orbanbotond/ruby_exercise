require 'spec_helper'

# module TrailblazerOperations
#   class Add < Trailblazer::Operation
#     step :check
#     step :validate
#     step :add

#     private
#     def check(options, **)
#       Railway.pass!
#     end

#     def validate(options, params:)
#       if params.all?{|x|x.finite?}
#         Railway.pass! #=> right track, success
#       else
#         options[:validation] = 'must be a real number'
#         Railway.fail! #=> left track, failure
#       end
#     end

#     def add(options, params:)
#       ret = params.reduce(0) { |acc, x| acc + x }
#       options[:operation_result] = ret
#     end
#   end

#   class Multiply < Trailblazer::Operation
#     step :validate
#     step :multiply

#     private

#     def validate(options, params:)
#       if params.all?{|x|x.finite?}
#         Railway.pass! #=> right track, success
#       else
#         options[:validation] = 'must be a real number'
#         Railway.fail! #=> left track, failure
#       end
#     end

#     def multiply(options, params:)
#       ret = params.reduce(1) { |acc, x| acc * x }
#       options[:operation_result] = ret
#     end
#   end

#   class ComplexOperation < Trailblazer::Operation
#     step Nested( Multiply,
#       input: -> (options, params:, **) do
#         options.merge params: params[-2..-1]
#       end
#     )

#     step Nested( Add,
#       input: -> (options, params:, **) do
#         options.to_hash.except(:operation_result).merge params: [params[0], options[:operation_result]]
#       end
#     )
#   end
# end

add = ->(params:) do
  if params.all?{|x|x.finite?}
    result = params.reduce(0) { |acc, x| acc + x }
    return { operation_result: result }
  else
    return { validation: 'must be a real number' }
  end
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

    context 'postitive cases' do
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

