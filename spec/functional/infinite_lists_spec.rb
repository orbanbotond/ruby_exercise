require 'spec_helper'

describe 'InfiniteLists' do
  context 'Enumerators' do
    numbers = Enumerator.new do |y|
      a = 1
      loop do
        y.yield a
        a += 1
      end
    end

    context 'without lazy' do
      require 'timeout'
      specify 'will timeout' do
        expect do
          status = Timeout::timeout(2) {
            numbers.select{|x|x % 5 == 0}.first(10)
          }
        end.to raise_error(Timeout::Error)
      end
    end
    context 'with lazy' do
      specify 'will be evaluated' do
        expect(numbers.lazy.select{|x|x % 5 == 0}.first(6)).to eq([5,10,15,20,25,30])
        expect(numbers.lazy.select{|x|x % 5 == 0}.select{|x|x%3 ==0}.first(4)).to eq([15,30,45,60])
      end
    end
  end

  context 'lazy stream by hand' do
    module EvenSeries
      class Node
        def initialize(number=0)
          @value = number
          @next = lambda { Node.new(number + 2) }
        end
        attr_reader :value
        def next
          @next.call
        end
      end
    end

    specify 'next generates the next value' do
      e = EvenSeries::Node.new(30)
      expect((e = e.next).value).to eq(32)
      expect((e = e.next).value).to eq(34)
      expect((e = e.next).value).to eq(36)
    end
  end

  context 'lazy stream lib' do
    #will be used later in other context as well.
    def integers_starting_from(n)
      lazy_stream(n) { integers_starting_from(n + 1) }
    end

    context 'integers' do
      specify 'generate a sequence' do
        expect(integers_starting_from(1).take(10).reduce(&:+) ).to eq(55)
      end
    end

    context 'fibonacci' do
      def fibgen(a, b)
        lazy_stream(a) { fibgen(b, a + b) }
      end

      specify 'generate a fibonacci sequence' do
        expect(fibgen(0, 1).take(10).to_a).to eq([0,1,1,2,3,5,8,13,21,34])
      end

      specify 'generate a fibonacci sequence' do
        expect(fibgen(0, 1).first).to eq(0)
        expect(fibgen(0, 1).rest.first).to eq(1)
        expect(fibgen(0, 1).rest.rest.first).to eq(1)
        expect(fibgen(0, 1).rest.rest.rest.first).to eq(2)
      end
    end

    context 'eratostenes sieve' do
      def sieve(stream)
        lazy_stream(stream.first) do
          sieve(stream.rest.select { |x| x % stream.first > 0 })
        end
      end

      def primes
        sieve(integers_starting_from(2))
      end

      specify 'primes' do
        expect(primes.take(10).to_a).to eq([2,3,5,7,11,13,17,19,23,29])
      end

      specify 'classes' do
        expect(primes.class).to eq(LazyStream)
        expect(primes.first.class).to eq(Fixnum)
        expect(primes.rest.class).to eq(LazyStream)
      end
    end

    context 'recursive mathematical declarations' do
      ones = lazy_stream(1) { ones }

      specify 'ones' do
        expect(ones.take(10).to_a).to eq([1,1,1,1,1,1,1,1,1,1])
      end

      specify 'integers' do
        integers = lazy_stream(1) { LazyStream.add(ones, integers) }

        expect(integers.take(3).to_a).to eq([1,2,3])
      end

      specify 'fibonacci' do
        fibonacci = lazy_stream(0) { lazy_stream(1) { LazyStream.add(fibonacci, fibonacci.rest)} }

        expect(fibonacci.take(6).to_a).to eq([0,1,1,2,3,5])
      end
    end

    context 'upto example' do
      context 'structured way just methods' do
        def upto( from, to )
          return [] if from > to
          lazy_stream(from) { upto(from + 1, to) }
        end

        specify '3..6' do
          expect(upto(3,6).to_a).to eq([3,4,5,6])
        end
      end

      context 'OO way' do
        class Upto < LazyStream
          def initialize( from, to )
            if from > to
              super(nil, &nil)
            else
              super(from) { self.class.new(from + 1, to) }
            end
          end
        end
        specify ':)s ...' do
          expect(Upto.new(3, 6).to_a).to eq([3,4,5,6])
        end
      end
    end

    context 'upfrom example' do
      context 'structured' do
        def upfrom( start )
          lazy_stream(start) { upfrom(start + 1) }
        end

        specify 'ups' do
          expect(upfrom(7).take(10).to_a).to eq([7,8,9,10,11,12,13,14,15, 16])
        end
      end
      context 'OO way' do
        class Upfrom < LazyStream
          def initialize( from )
            super(from) { self.class.new(from + 1) }
          end
        end
        specify ':)s ...' do
          expect(Upfrom.new(7).take(5).to_a).to eq([7,8,9,10,11])
        end
      end
    end

    context 'grouping example' do
      class Step < LazyStream
        def initialize( step, start = 1 )
          super(start) { self.class.new(step, start + 1) }
          @step = step
        end

        def next_group( count = 10 )
          take(count).map { |i| i * @step }
        end
      end

      specify 'return the series in group' do
        evens = Step.new(2)
        expect((evens = evens.next_group).to_a).to eq([2,4,6,8,10,12,14,16,18,20])
        expect do
          expect(evens.next_group.to_a).to eq([22,24,26,28,30,32,34,36,38,40])
        end.to raise_error(NameError)
      end
    end
  end
end
