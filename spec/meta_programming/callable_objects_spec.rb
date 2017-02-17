require 'spec_helper'

describe 'Callable Objects' do
  context 'when yield is not enough' do
    specify 'when we pass a block to a callable' do
      def math(a, b)
        yield(3, a + b)
      end

      def more_math(a, b, &operation)
        #converting the operation proc back to block again
        math(a, b, &operation)
      end

      def more_math_2(a, b, &operation)
        #operation is block
        operation.call(a,b)
      end

      expect(math(1,2){|x,y| x*y}).to eq(9)
      expect(more_math(1,2){|x,y| 3 * x + y}).to eq(12)
      expect(more_math_2(1,2){|x,y| 3 * x + y}).to eq(5)
    end
  end

  context 'deferred evaluation' do
    specify 'stores and executes later' do
      class Deferred
        attr_accessor :executable, :param
        def initialize(param, &block)
          self.executable = block
          self.param = param
        end

        def execute(a,b)
          executable.call(param, a, b)
        end
      end

      deferred = Deferred.new(5) {|x,y,z| 3*x*x*x + 4*y + z}

      expect(deferred.execute(4,5)).to eq(3*125 + 4*4 + 5)
    end
  end

  context 'return difference lambda vs. proc' do
    context 'lambda' do
      specify 'it returns just from the lambda and the defining code continues' do
        def double()
          l = lambda { return 10 }
          result = l.call * 2
          return result * 3
        end
        expect(double()).to eq(60)
      end
    end

    context 'proc' do
      specify 'it returns from the defining scope' do
        def another_double
          p = Proc.new { return 10 }
          result = p.call * 2
          return result * 3
        end
        expect(another_double()).to eq(10)
      end
    end
  end

  context 'argument checking' do
    context 'lambda' do
      specify 'will check the arity' do
        p = lambda {|a, b| [a, b]}
        expect(p.arity).to eq(2)

        expect do
          p.call(1)
        end.to raise_error(ArgumentError)

        expect do
          p.call(1, 2, 3)
        end.to raise_error(ArgumentError)
      end
    end

    context 'proc' do
      specify 'will check the arity' do
        p = Proc.new {|a, b| [a, b]}
        expect(p.arity).to eq(2)

        expect do
          p.call(1)
        end.to_not raise_error

        expect do
          p.call(1, 2, 3)
        end.to_not raise_error
      end
    end
  end
end
