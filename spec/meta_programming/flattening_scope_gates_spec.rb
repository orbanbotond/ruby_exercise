require 'spec_helper'

#  These tehcniques are also called:
#  nested lexical scopes
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

  context 'using the scope barrier to share a secred variable' do
    specify 'the variable will be shared but not visible from the outside' do
      def define_methods
        shared = 0
        Kernel.send :define_method, :counter do shared
        end

        Kernel.send :define_method, :inc do |x| shared += x
        end

        expect { shared }.to raise_error(NameError)
        expect(counter).to eq(0)
        inc
        inc
        expect(counter).to eq(2)
      end
    end
  end
end
