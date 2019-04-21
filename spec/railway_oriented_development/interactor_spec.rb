
# # class CreateAccount
# #   include Dry::Monads::Result::Mixin
# #   include Dry::Monads::Do.for(:call)

# #   def call(params)
# #     values = yield validate(params)
# #     account = yield create_account(values[:account])
# #     owner = yield create_owner(account, values[:owner])

# #     Success([account, owner])
# #   end

# #   def validate(params)
# #     # returns Success(values) or Failure(:invalid_data)
# #   end

# #   def create_account(account_values)
# #     # returns Success(account) or Failure(:account_not_created)
# #   end

# #   def create_owner(account, owner_values)
# #     # returns Success(owner) or Failure(:owner_not_created)
# #   end
# # end

# require 'spec_helper'

# module MonadDoNotation
#   class Add
#     include Dry::Monads::Result::Mixin
#     include Dry::Monads::Do::All

#     def call(arguments)
#       validation_result = yield validate(arguments)
#       operation_result = yield add(arguments)

#       Success validation_result.merge( operation_result)
#     end

#     private

#     def validate(input)
#       return Failure(validation: 'must be a real number') unless input.all?{|x|x.finite?}

#       Success(validation: :ok)
#     end

#     def add(input)
#       ret = input.reduce(0) { |acc, x| acc + x }

#       Success(operation_result: ret)
#     end
#   end

#   class Multiply
#     include Dry::Monads::Result::Mixin
#     include Dry::Monads::Do::All

#     def call(arguments)
#       validation_result = yield validate(arguments)
#       operation_result = yield multiply(arguments)

#       Success validation_result.merge( operation_result)
#     end

#     private

#     def validate(input)
#       return Failure(validation: 'must be a real number') unless input.all?{|x|x.finite?}

#       Success(validation: :ok)
#     end

#     def multiply(input)
#       ret = input.reduce(1) { |acc, x| acc * x }

#       Success(operation_result: ret)
#     end
#   end

#   class ComplexOperation
#     include Dry::Monads::Result::Mixin
#     include Dry::Monads::Do::All


#     def call(input)
#       multiplication = yield multiply(input[-2..-1])
#       addition = yield add([input[0], multiplication[:operation_result]])

#       Success(addition)
#     end

#     private
#     def multiply(args)
#       Multiply.new.call args
#     end

#     def add(args)
#       Add.new.call args
#     end
#   end
# end

# describe 'DryTransactions' do
#   context 'add' do
#     subject { MonadDoNotation::Add.new.call params }
#     let(:params) { [2,3,4] }

#     context 'negative cases' do
#       context 'params infinite' do
#         let(:params) { [(1.0/0.0), 2] }

#         specify 'Be a failure with a proper error message' do
#           expect(subject).to be_failure
#           expect(subject.failure[:validation]).to eq 'must be a real number'
#         end
#       end
#     end

#     context 'postitive cases' do
#       specify 'Be a success with the proper correct output' do
#         expect(subject).to be_success
#         expect(subject.value![:validation]).to eq(:ok)
#         expect(subject.value![:operation_result]).to eq(params.reduce(0) { |acc, x| acc + x })
#       end
#     end
#   end

#   context 'multiply' do
#     subject { MonadDoNotation::Multiply.new.call params }
#     let(:params) { [2,3,4] }

#     context 'negative cases' do
#       context 'params infinite' do
#         let(:params) { [(1.0/0.0), 2] }

#         specify 'Be a failure with a proper error message' do
#           expect(subject).to be_failure
#           expect(subject.failure[:validation]).to eq 'must be a real number'
#         end
#       end
#     end

#     context 'postitive cases' do
#       specify 'Be a success with the proper correct output' do
#         expect(subject).to be_success
#         expect(subject.value![:validation]).to eq(:ok)
#         expect(subject.value![:operation_result]).to eq(params.reduce(1) { |acc, x| acc * x })
#       end
#     end
#   end

#   context 'nesting' do
#     subject { MonadDoNotation::ComplexOperation.new.call params }
#     let(:params) { [2,3,4] }

#     context 'negative cases' do
#       context 'params infinite' do
#         let(:params) { [(1.0/0.0), 2, 4] }

#         specify 'Be a failure with a proper error message' do
#           expect(subject).to be_failure
#           expect(subject.failure[:validation]).to eq 'must be a real number'
#         end
#       end

#       context 'params infinite 2' do
#         let(:params) { [2, (1.0/0.0), 4] }

#         specify 'Be a failure with a proper error message' do
#           expect(subject).to be_failure
#           expect(subject.failure[:validation]).to eq 'must be a real number'
#         end
#       end
#     end

#     context 'postitive cases' do
#       specify 'Be a success with the proper correct output' do
#         expect(subject).to be_success
#         expect(subject.value![:operation_result]).to eq(params[0] + params[1] * params[2])
#         expect(subject.value![:validation]).to eq(:ok)
#       end
#     end
#   end
# end

