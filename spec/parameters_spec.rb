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

    specify 'keyword arguments' do
      # unfortunatelly the below is not supported.
      # def a(required, optional1 => 'opt1', optional2 => 'opt2')
      def a(required, keys = {})
        key1 = keys.fetch(:optional1){'opt1'}
        key2 = keys.fetch(:optional2){'opt2'}
        [required, key1, key2]
      end

      expect(a('Cseva')).to eq(['Cseva', 'opt1', 'opt2'])
      expect(a('Cseva', optional1: 'Optional1 specified')).to eq(['Cseva', 'Optional1 specified', 'opt2'])
      expect(a('Cseva', optional2: 'Optional2 specified')).to eq(['Cseva', 'opt1', 'Optional2 specified'])
      expect(a('Cseva', optional2: 'Optional2 specified', optional1: 'Optional1 specified')).to eq(['Cseva', 'Optional1 specified', 'Optional2 specified'])
      expect(a('Cseva', optional1: 'Optional1 specified', optional2: 'Optional2 specified')).to eq(['Cseva', 'Optional1 specified', 'Optional2 specified'])
    end
  end
end

