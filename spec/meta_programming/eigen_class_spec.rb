require 'spec_helper'

class Object
  def eigenclass
    class << self; 
      self; 
    end 
  end
end

context 'EigenClasses' do

  class MyClass
    class << self
      def just_here
      end
    end
  end

  class MyDerivedClass < MyClass
  end

  # So basically the 'class methods' are simple methods on the class EigenClass.
  specify 'eigenclass method' do
    expect(MyClass.singleton_methods).to include(:just_here)
    expect(MyDerivedClass.singleton_methods).to include(:just_here)

    expect { MyDerivedClass.just_here }.to_not raise_error
  end

  # MyClass class is an instance of Class

  specify 'eigenclass superclass is out class' do
    expect(MyClass.eigenclass.superclass.to_s).to eq('#<Class:Object>')
    expect(MyDerivedClass.eigenclass.superclass.to_s).to eq('#<Class:MyClass>')
  end

  obj = MyClass.new
  specify 'eigenclass superclass is out class' do
    expect(obj.eigenclass.to_s).to include('#<My')
    expect(obj.eigenclass.superclass).to eq(MyClass)
  end

  specify 'eigenclasses instance methods are the singleton methods' do
    def obj.my_singleton_method
      'a'
    end
    expect(obj.eigenclass.instance_methods).to include(:my_singleton_method)
  end
end
