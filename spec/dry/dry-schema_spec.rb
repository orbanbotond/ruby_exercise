require 'spec_helper'

describe 'Dry-Schema' do
  describe 'structural validation' do
    context 'key presence' do
      context 'optional keys' do
        subject(:schema_validation) do
          schema = Dry::Schema.Params do
            optional(:age)
          end

          schema.call params
        end

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

      context 'mandatory keys' do
        subject(:schema_validation) {
          schema = Dry::Schema.Params do
            required(:age)
          end

          schema.call params
        }

        context 'negative' do
          context 'key is missing' do
            let(:params) { {} }

            it { should be_failure }

            it "the errors should point to the missing key" do
              expect(schema_validation.errors.to_h).to include(:age)
            end
          end
        end

        context 'positive' do
          context 'key is present' do
            let(:params) { {age: 123} }

            it { should be_success }

            it "the errors should be empty" do
              expect(schema_validation.errors).to be_empty
            end
          end
        end
      end
    end

    context 'value presence' do
      context 'optional values' do
        subject(:schema_validation) {
          schema = Dry::Schema.Params do
            required(:name).maybe(:string)

            #The default is maybe
            required(:another_maybe_field)
          end

          schema.call params
        }

        context 'negative' do
          # Since values are optional there is no failing case here. 
        end

        context 'positive' do
          context 'missing value' do
            let(:params) { { name: nil, another_maybe_field: nil } }

            it { should be_success }

            it "the errors should be empty" do
              expect(schema_validation.errors).to be_empty
            end
          end

          context 'present key' do
            let(:params) { {name: 'value', another_maybe_field: nil } }

            it { should be_success }

            it "the errors should be empty" do
              expect(schema_validation.errors).to be_empty
            end
          end
        end
      end

      context 'mandatory value' do
        subject(:schema_validation) {
          schema = Dry::Schema.Params do
            required(:name).filled(:string)
          end

          schema.call params
        }

        context 'negative' do
          context 'missing value' do
            let(:params) { { name: nil } }

            it { should be_failure }

            it "the errors should point out the missing key" do
              expect(schema_validation.errors.to_h).to include(:name)
            end
          end
        end

        context 'positive' do
          context 'present key' do
            let(:params) { {name: 'value' } }

            it { should be_success }

            it "the errors should be empty" do
              expect(schema_validation.errors).to be_empty
            end
          end
        end
      end
    end
  end

  describe 'type checking' do
  end

  describe 'schema reuse' do
  end

  describe 'custom predicates' do
  end

  describe 'strict key presence' do
  end
end
