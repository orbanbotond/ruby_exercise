require 'spec_helper'

#  These tehcniques are also called:
#  nested lexical scopes
describe 'Instance Eval' do
  before do
    create_temporary_class 'MyClass' do
      include ::RSpec::Matchers

      def initialize
        @v = 1
      end
    end
  end

  specify 'will have access to instance variables' do
    obj = MyClass.new
    obj.instance_eval do
      expect(@v).to eq(1)
    end
  end

  specify 'changes the current class to the eigenclass of the receiver' do
    obj = MyClass.new
    obj.instance_eval do
      expect(self.class).to eq(MyClass)
    end
  end

  before do
    create_temporary_class 'C' do
      def initialize
        @x, @y = 1, 2
      end
    end
  end

  specify 'instance exec' do
    expect(C.new.instance_exec(3) {|arg| (@x + @y) * arg }).to eq(9)
  end
end
