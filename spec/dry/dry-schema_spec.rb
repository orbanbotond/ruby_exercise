require 'spec_helper'

describe 'Dry Schema' do
  class MyContainer
    extend Dry::Container::Mixin

    register "users_repository" do
      UsersRepository.new
    end

    register "operations.create_user" do
      CreateUser.new
    end
  end

  context 'Structural Validation' do
    context 'Key Presence' do
      context 'Both the Key And Value are Optional' do
        subject(:schema_validation) {
          schema = Dry::Schema.Params do
            optional(:age)
          end

          schema.call params
        }

        context 'negative' do
          # Since everything is optional there is no way to fail the schema
        end

        context 'positive' do
          context 'missing key' do
            let(:params) { {} }

            it { should be_success }

            it "Errors should be empty" do
              expect(schema_validation.errors).to be_empty
            end
          end

          context 'present key' do
            context 'nil value' do
              let(:params) { {age: nil} }

              it { should be_success }

              it "Errors should be empty" do
                expect(schema_validation.errors).to be_empty
              end
            end

            context 'present value' do
              let(:params) { {age: 123} }

              it { should be_success }

              it "Errors should be empty" do
                expect(schema_validation.errors).to be_empty
              end
            end
          end
        end
      end
    end
  end
end
