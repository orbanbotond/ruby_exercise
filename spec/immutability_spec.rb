require 'spec_helper'

describe 'Immutability' do
  # The typical example for a mutable object and lot of questions
  # is the activerecord
  # take a look at the ar.errors
  # ar.valid? then ar.errors
  # state inconsistency...

  context 'With adamantium' do
    specify 'raises an error if we modify the object' do
      class A
        include Adamantium

        def initialize(a)
          @a = a
        end

        attr_accessor :a
      end

      a = A.new('Immutable')

      expect { a.a = 'New value' }.to raise_error(RuntimeError)
    end

    specify 'it freezes the nested objects too' do
      class A
        include Adamantium

        def initialize(a)
          @a = a
        end

        attr_accessor :a
      end

      class B < Struct.new(:a)
      end

      a_nested = B.new('Immutable')
      a = A.new(a_nested)

      expect(a.a).to be_frozen
    end
  end
end
