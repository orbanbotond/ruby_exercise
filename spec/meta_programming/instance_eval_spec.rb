require 'spec_helper'

#  These tehcniques are also called:
#  nested lexical scopes
describe 'Instance Eval' do
  specify 'will have access to instance variables' do
    class MyClass
      include ::RSpec::Matchers

      def initialize
        @v = 1
      end
    end
    obj = MyClass.new
    obj.instance_eval do
      # self # => #<MyClass:0x3340dc @v=1>
      expect(@v).to eq(1)
    end
  end

  specify 'instance exec' do
    class C
      def initialize
        @x, @y = 1, 2
      end
    end
    expect(C.new.instance_exec(3) {|arg| (@x + @y) * arg }).to eq(9)
  end
end
