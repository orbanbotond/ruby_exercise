require 'spec_helper'

# http://stackoverflow.com/questions/1788923/parameter-vs-argument
# A parameter is the variable which is part of the method’s signature (method declaration). An argument is an expression used when calling the method.

# Consider the following code:

# void Foo(int i, float f)
# {
#     // Do things
# }

# void Bar()
# {
#     int anInt = 1;
#     Foo(anInt, 2.0);
# }
# Here i and f are the parameters, and anInt and 2.0 are the arguments.

describe 'Parameters' do
  context 'simplest case' do
    specify 'multiple parameters with default values' do
      def a(name, taip='DefaultOne')
        [name, taip]
      end
      expect(a('Name')).to eq(['Name', 'DefaultOne'])
      expect(a('Name', 'OverridenType')).to eq(['Name', 'OverridenType'])
    end

    specify 'arrayish parameters types' do
      def a(*params)
        params
      end
      expect(a('Name')).to eq(['Name'])
      expect(a('Name', 'OverridenType')).to eq(['Name', 'OverridenType'])
    end

    specify 'arrayish parameters types' do
      def a(named_param, *params)
        [named_param, params]
      end
      expect(a('Name')).to eq(['Name', []])
      expect(a('Name', 'OverridenType', 'Second')).to eq(['Name', ['OverridenType', 'Second']])
    end

    specify 'named, optional, arrayish' do
      def a(required, optional='opt', *rest)
        [required, optional, rest]
      end

      expect(a('Name')).to eq(['Name', 'opt',[]])
      expect(a('Name', 'OverridenType')).to eq(['Name', 'OverridenType', []])
    end

    specify 'expanding an array into multiple arguments' do
      def a(required, optional='opt', *rest)
        [required, optional, rest]
      end

      expect(a(['a', 'b', 'c', 'd', 'e', 'f'])).to eq([['a', 'b', 'c', 'd', 'e', 'f'], 'opt',[]])
      expect(a(*['a', 'b', 'c', 'd', 'e', 'f'])).to eq(['a', 'b', ['c', 'd', 'e', 'f']])
    end
  end
end

