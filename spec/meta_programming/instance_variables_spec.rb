require 'spec_helper'

context 'Class Eval' do
  before do
    create_temporary_class 'MyClass' do
      @my_var = 1
      def self.read
        @my_var
      end
      def write
        @my_var = 2
      end
      def read
        @my_var
      end
    end
  end

  specify 'class instance variable is different from instance variable.' do
    obj = MyClass.new
    obj.write
    expect(obj.read).to eq(2)
    expect(MyClass.read).to eq(1)
  end

  context 'class variables' do
    before do
      create_temporary_class 'C' do
        @@v = 11
        @v = 1

        def getClassVariableV
          @@v
        end

        def getClassInstanceVariableV
          @v
        end

        def self.getInstanceVariableV
          @v
        end
      end

      create_temporary_class 'D', C do
      end
    end

    specify 'access class variable' do
      c = C.new
      expect(c.getClassVariableV).to eq(11)
      expect(c.getClassInstanceVariableV).to be_nil
      expect(C.getInstanceVariableV).to eq(1)

      d = D.new
      expect(d.getClassVariableV).to eq(11)
      expect(d.getClassInstanceVariableV).to be_nil
      expect(D.getInstanceVariableV).to be_nil
    end
  end
end
