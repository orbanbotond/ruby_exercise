class Sandbox

  i = 0

  A = Class.new do
    define_method :i do
      i
    end
  end

  define_method :xx do
    i += 1
  end

  define_method :yy do
    i
  end

end

require 'spec_helper'

describe 'Flat scopes' do

  specify 'can access the variables outside the default scope gate by flattening' do
    sandbox = Sandbox.new
    expect(sandbox.xx).to eq(1)
    expect(sandbox.yy).to eq(1)
    expect(Sandbox::A.new.i).to eq(1)
  end

  specify 'can not access local variable out of scope gate' do
    my_var = "Success"
    class MyClass
      # We want to print my_var here...
      puts my_var
      def my_method
        puts my_var
      # ..and here
      end
    end

    
  end

end
