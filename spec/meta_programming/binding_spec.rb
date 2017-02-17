require 'spec_helper'

# include ::RSpec::Matchers
@var = "The top-level @var"
def my_method 
  return @var
end

# expect(my_method).to eq(@var)

describe 'Binding' do
  context 'basic binding' do
    specify 'grab the binding at the moment it is defined.' do
      def my_method
        x = "Goodbye"      
        yield("cruel" ) 
      end
      x = "Hello"
      expect(my_method {|y| "#{x}, #{y} world" }).to eq('Hello, cruel world')
    end
  end

  context 'binding dissapearance' do
    specify 'it dissapears after the block' do
      def my_method
        yield
      end

      top_level_variable = 1 
      my_method do
        top_level_variable += 1
        local_to_block = 1
      end
      expect(top_level_variable).to eq(2)
      expect { local_to_block }.to raise_error(NameError)
    end
  end

  context 'scope gates inspection' do
    specify '' do
      v1 = 1
      class MyClass
        #since class is a 'scope gate' the rspec expectation methods need to be included and extended
        include ::RSpec::Matchers
        extend ::RSpec::Matchers
        v2 = 2

        expect(local_variables).to eq([:v2])
        def my_method 
          v3 = 3

          expect(local_variables).to eq([:v3])
        end
        expect(local_variables).to eq([:v2])
      end
      obj = MyClass.new
      obj.my_method
      obj.my_method
      expect(local_variables).to eq([:v1, :obj])
    end
  end

  context 'global variables' do
    specify 'can be accessed from anywhere' do
      def a_scope
        $var = "some value"
      end
      def another_scope 
        $var
      end
      a_scope
      expect(another_scope).to eq(a_scope)
    end
  end

  context 'top level instance variables' do
    specify 'will be blocked by a scope gate' do
      expect(my_method).to be_nil
    end
  end
end
