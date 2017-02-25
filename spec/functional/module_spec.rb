require 'spec_helper'

describe 'Module' do
  module A
    module_function
    def foo
      "This is #{bar}"
    end
    def bar
      "This is bar"
    end
    def foo2
      baz
    end
    private
    def baz
      "hi there"
    end
  end

  specify 'Module Functions can be called like class methods' do
    expect(A.foo).to eq('This is This is bar')
    expect(A.bar).to eq('This is bar')
  end

  specify 'Can not call private methods' do
    expect do
      A.foo2
    end.to raise_error(NameError)
  end

  context 'calling privates' do
    module AA
      extend self
      def foo
        "This is foo calling baz: #{baz}"
      end
      private
      def baz
        "hi there"
      end
    end

    specify 'Can call private methods embedded in public' do
      expect do
        AA.foo
      end.to_not raise_error
      expect(AA.foo).to eq('This is foo calling baz: hi there')
    end

    specify 'Can not call private methods' do
      expect do
        AA.baz
      end.to raise_error(NoMethodError)
    end
  end
end
