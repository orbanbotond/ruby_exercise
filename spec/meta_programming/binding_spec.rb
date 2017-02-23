require 'spec_helper'

describe 'Binding' do
  class MyClass
    def a
      v1 = 2
      a = 2
      binding
    end
  end

  specify 'will have access to instance variables' do
    b = MyClass.new.a
    expect(eval('v1',b)).to eq(2)
  end
end
