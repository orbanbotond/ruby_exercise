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
    context 'simple types' do
      subject(:schema_validation) {
        schema = Dry::Schema.Params do
          required(:name).filled(:string)
        end

        schema.call params
      }

      context 'negative' do
        context 'wrong type is passed as value' do
          let(:params) { { name: 2 } }

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

    describe 'hash' do
      context 'mandatory hash' do
        subject(:schema_validation) do
          schema = Dry::Schema.Params do
            required(:address).hash do
            end
          end

          schema.call params
        end

        context 'negative' do
          context 'wrong type is passed as value' do
            let(:params) { { address: 'asd' } }

            it { should be_failure }

            it "the errors should point out the missing key" do
              expect(schema_validation.errors.to_h).to include(:address)
            end
          end

          context 'nil is passed as value' do
            let(:params) { { address: nil } }

            it { should be_failure }

            it "the errors should point out the missing key" do
              expect(schema_validation.errors.to_h).to include(:address)
            end
          end
        end

        context 'positive' do
          context 'present key' do
            let(:params) { { address: {} }}

            it { should be_success }

            it "the errors should be empty" do
              expect(schema_validation.errors).to be_empty
            end
          end
        end
      end

      context 'optional hash' do
        subject(:schema_validation) do
          schema = Dry::Schema.Params do
            required(:address).maybe do
              hash do
              end
            end
          end

          schema.call params
        end

        context 'negative' do
          context 'wrong type is passed as value' do
            let(:params) { { address: 'asd' } }

            it { should be_failure }

            it "the errors should point out the missing key" do
              expect(schema_validation.errors.to_h).to include(:address)
            end
          end
        end

        context 'positive' do
          context 'nil is passed as value' do
            let(:params) { { address: nil } }

            it { should be_success }

            it "the errors should be empty" do
              expect(schema_validation.errors).to be_empty
            end
          end

          context 'present key' do
            let(:params) { { address: {} }}

            it { should be_success }

            it "the errors should be empty" do
              expect(schema_validation.errors).to be_empty
            end
          end
        end 
      end
    end

    describe 'arrays' do
      subject(:schema_validation) {
        schema = Dry::Schema.Params do
          required(:names).array(:string)
        end

        schema.call params
      }

      context 'negative' do
        context 'wrong type is passed as value' do
          let(:params) { { names: 'asd' } }

          it { should be_failure }

          it "the errors should point out the missing key" do
            expect(schema_validation.errors.to_h).to include(:names)
          end
        end
      end

      context 'positive' do
        context 'present key' do
          let(:params) { { names: ['Name 1', 'Name 2'] } }

          it { should be_success }

          it "the errors should be empty" do
            expect(schema_validation.errors).to be_empty
          end
        end
      end
    end

    context 'array of hashes' do
      subject(:schema_validation_for_array_of_hashes) {
        schema = Dry::Schema.Params do
          required(:addresses).array(:hash) do
            required(:street).filled(:string)
          end
        end

        schema.call params
      }

      context 'negative' do
        context 'wrong type is passed as value' do
          let(:params) { { addresses: [1, 2] } }

          it { should be_failure }

          it "the errors should point out the missing key" do
            expect(schema_validation_for_array_of_hashes.errors.to_h).to include(:addresses)
          end
        end
      end

      context 'positive' do
        context 'present key' do
          let(:params) { { addresses: [{street: 'Sir. John'}, {street: 'Pompierilor'}] } }

          it { should be_success }

          it "the errors should be empty" do
            expect(schema_validation_for_array_of_hashes.errors).to be_empty
          end
        end
      end
    end
  end

  describe 'value' do
    subject(:schema_validation_for_array_of_hashes) {
      schema = Dry::Schema.Params do
        required(:address).value(:nil?)
      end

      schema.call params
    }

    context 'negative' do
      context 'wrong type is passed as value' do
        let(:params) { { address: 1 } }

        it { should be_failure }

        it "the errors should point out the missing key" do
          expect(schema_validation_for_array_of_hashes.errors.to_h).to include(:address)
        end
      end
    end

    context 'positive' do
      context 'present key' do
        let(:params) { { address: nil } }

        it { should be_success }

        it "the errors should be empty" do
          expect(schema_validation_for_array_of_hashes.errors).to be_empty
        end
      end
    end
  end

  describe 'nested schemas' do
    # See the 'hash/mandatory hash' context
  end

  describe 'schema reuse' do
    subject(:schema_validation_for_array_of_hashes) {
      AddressSchema = Dry::Schema.Params do
        required(:street).filled(:string)
        required(:city).filled(:string)
      end

      schema = Dry::Schema.Params do
        required(:email).filled(:string)
        required(:address).hash(AddressSchema)
      end
      schema.call params
    }

    context 'positive' do
      let(:params) { { email: 'email_address', address: { street: 'Oxford', city: 'London'} } }

      it { should be_success }

      it "the errors should be empty" do
        expect(schema_validation_for_array_of_hashes.errors).to be_empty
      end
    end
  end

  describe 'custom predicates' do
    # These are only in the dry Validation
  end

  describe 'strict key presence' do
    # These are only in the dry Validation
  end
end
