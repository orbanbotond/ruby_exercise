require 'spec_helper'

context 'Class Eval' do
  specify 'reference to the current class is kept.' do
    class MyClass
      def method_one
        def method_two
          'Hello!'
        end
      end
    end

    nnn = MyClass.new
    expect(nnn).to respond_to(:method_one)
    expect(nnn.method_one).to eq(:method_two)
    expect(nnn).to respond_to(:method_two)
  end

  specify 'The method appears after class_eval' do
    a_class = Integer

    expect(1).to_not respond_to(:new_method)

    def add_method_to(a_class)
      a_class.class_eval do
        def new_method
          'Hello!'
        end
      end
    end

    add_method_to(a_class)
    expect(1).to respond_to(:new_method)
    expect(1.new_method).to eq('Hello!')
  end
end
