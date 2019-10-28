require 'spec_helper'

describe 'Dry-Validation' do
  describe 'just schema' do
    before do
      create_temporary_class 'NewUserContract', Dry::Validation::Contract do
        params do
          required(:email).filled(:string)
          required(:age).value(:integer)
        end

        rule(:age) do
          key.failure('has invalid format')
        end
      end
    end

    subject(:contract_validation) { NewUserContract.new.call(params) }
    let(:params) { { email: "asds@asd.com", age: nil } }

    it { should be_failure }

    specify "The age rule is not run untill the schema passes" do

      # The rule isn't run untill the schema passes
      expect(contract_validation.errors.to_h[:age]).to_not eq('has invalid format')
    end
  end

  describe 'rules' do
    context 'rule dependencies' do
      before do
        create_temporary_class 'NewUserContract', Dry::Validation::Contract do
          params do
            required(:email).filled(:string)
            required(:age).value(:integer)
          end

          rule(:email) do
            unless /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i.match?(value)
              key.failure('has invalid format')
            end
          end

          rule(:email) do
            unless /\.com\z/i.match?(value)
              key.failure('must end in .com')
            end
          end

          rule(:age) do
            key.failure('must be greater than 18') if value < 18
          end
        end
      end

      context 'both rules are run' do
        subject(:contract_validation) { NewUserContract.new.call(params) }
        let(:params) { { email: 'blagmailcom', age: 16 } }

        it { should be_failure }

        specify "Both email rules are run" do
          expect(contract_validation.errors.to_h).to include(:age)
          expect(contract_validation.errors.to_h[:email]).to include 'must end in .com'
          expect(contract_validation.errors.to_h[:email]).to include 'has invalid format'
        end
      end
    end

    #How to force both of the rules?
  end

  describe 'custom predicates' do
  end

  describe 'strict key presence' do
  end
end
