require 'spec_helper'
require 'active_support/duration.rb'
require 'active_support/core_ext/numeric'

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

    context 'rules with many keys' do
      before do
        create_temporary_class 'EventContract', Dry::Validation::Contract do
          params do
            required(:start_date).value(:date)
            required(:end_date).value(:date)
          end

          rule(:end_date, :start_date) do
            key.failure('must be after start date') if values[:end_date] < values[:start_date]
          end
        end
      end

      subject(:contract_validation) { EventContract.new.call(params) }
      let(:params) { { end_date: 1.days.from_now.to_date, start_date: 2.day.from_now.to_date } }

      it { should be_failure }

      specify "The error is inserted under the first key in the rule" do
        expect(contract_validation.errors.to_h[:end_date]).to be_present
        expect(contract_validation.errors.to_h[:start_date]).to be_blank
      end
    end

    context 'explicitely stating the key' do
      before do
        create_temporary_class 'EventContract', Dry::Validation::Contract do
          params do
            required(:start_date).value(:date)
            required(:end_date).value(:date)
          end

          rule(:end_date, :start_date) do
            key(:dates).failure('must be after start date') if values[:end_date] < values[:start_date]
          end
        end
      end

      subject(:contract_validation) { EventContract.new.call(params) }
      let(:params) { { end_date: 1.days.from_now.to_date, start_date: 2.day.from_now.to_date } }

      it { should be_failure }

      specify "The error is inserted under the first key in the rule" do
        expect(contract_validation.errors.to_h[:end_date]).to be_blank
        expect(contract_validation.errors.to_h[:start_date]).to be_blank
        expect(contract_validation.errors.to_h[:dates]).to be_present
      end
    end

    context 'base rules' do
      before do
        create_temporary_class 'EventContract', Dry::Validation::Contract do
          option :today, default: Date.method(:today)

          params do
            required(:start_date).value(:date)
            required(:end_date).value(:date)
          end

          rule do
            if today.saturday? || today.sunday?
              base.failure 'creating events is allowed only on weekdays'
            end
          end
        end
      end
      subject(:contract_validation) { EventContract.new.call(params) }
      let(:params) { { end_date: 2.days.from_now.to_date, start_date: 1.day.from_now.to_date } }

      context 'weekdays' do
        it { should be_success }
      end

      context 'weekends' do
        subject(:contract_validation) { EventContract.new(today: today).call(params) }
        let(:today) { Date.today.end_of_week }

        it { should be_failure }

        specify "The error is inserted under the first key in the rule" do
          expect(contract_validation.errors.to_h[nil]).to be_present
        end
      end
    end
  end

  describe 'custom predicates' do
  end

  describe 'strict key presence' do
  end
end
