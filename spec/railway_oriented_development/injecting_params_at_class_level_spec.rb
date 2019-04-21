require 'spec_helper'

module CRUD
  class Update
    include Dry::Transaction

    step :validate
    step :persist


    def validate(input)
      Success(input.to_s + model_class.to_s)
    end

    def persist(input)
      Success(input.to_s + model_class.to_s)
    end
  end

  class ORMModel1
  end

  class Update1 < Update
    def model_class
      ORMModel1
    end
  end
end

describe 'ParamOverride' do
  context 'update1' do
    subject { CRUD::Update1.new.call params }
    let(:params) { {a:1,b:2} }

    context 'negative cases' do
      specify 'inheritance just does not work' do
        expect(subject).to be_success
        expect(subject.value!).to_not eq('{}ORMModel1')
      end
    end
  end
end
