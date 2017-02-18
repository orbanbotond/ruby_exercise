require 'spec_helper'

context 'Class Eval' do
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
