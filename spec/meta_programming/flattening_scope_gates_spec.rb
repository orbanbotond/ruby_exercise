require 'spec_helper'

describe 'Passing Scope Gates' do
  context 'flattening class scope barrier' do
    specify 'will have access to other variables as well' do    
      my_var = 'Success'
      MyClass = Class.new do
        include ::RSpec::Matchers
        extend ::RSpec::Matchers


        expect(my_var).to eq('Success')

        def my_method
        end
      end
    end
  end

  context 'flattening the def scope barrier' do
    specify 'will have access to other variables as well' do    
      my_var = 'Success'
      MyClass = Class.new do
        include ::RSpec::Matchers
        extend ::RSpec::Matchers

        define_method :my_method do
          expect(my_var).to eq('Success')
        end
      end
    end
  end

end
