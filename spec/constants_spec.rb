require 'spec_helper'

describe 'Constants' do

  module self::MyModule
    MyConstant = 'Outer constant'
    class MyClass
      MyConstant = 'Inner constant'
    end
  end

  specify 'The two constants are different' do
    expect(self.class::MyModule::MyConstant).to eq('Outer constant')
    expect(self.class::MyModule::MyClass::MyConstant).to eq('Inner constant')
  end

  # module M
  #   Y = 'another constant'
  #   class C
  #     # specify 'Accessing the other constant' do
  #     #   expect(::M::Y).to eq('another constant')
  #     #   expect(::Y).to eq('another constant')
  #     # end

  #     ::M::Y # => "another constant"
  #   end
  # end
end
