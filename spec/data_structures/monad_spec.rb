require 'spec_helper'

describe 'Monad' do
  M = Dry::Monads

  context 'basics' do
    context 'bind' do
      specify 'value' do
        a = M.Maybe(2)
        expect(a.bind{|x|x}).to eq(2)
      end
      specify 'nil' do
        a = M.Maybe(nil)
        expect(a.bind{|x|x}).to eq(M.None())
      end
    end

    context 'fmap' do
      specify 'value' do
        a = M.Maybe(2)
        expect(a.fmap{|x|x}).to eq(M.Some(2))
      end
      specify 'nil' do
        a = M.Maybe(nil)
        expect(a.fmap{|x|x}).to eq(M.None())
      end
    end
  end

  context 'try' do
    context 'the methods' do
      specify 'basic' do
        extend Dry::Monads::Try::Mixin
        res = Try() { 10 / 2 }
        expect(res.success?).to be_truthy
        expect(res.value).to eq(5)
      end

      specify '#exception' do
        extend Dry::Monads::Try::Mixin
        res = Try() { 10 / 0 }
        expect(res.failure?).to be_truthy
        expect(res.exception).to be_a(ZeroDivisionError)
      end
    end
  end

  context 'either' do
    context 'the main benefit' do
      def monad(foo, bar)
        result = if foo > bar
          M.Right(10)
        else
          M.Left("wrong")
        end.fmap { |x| x * 2 }
      end

      specify 'The fmap can be executed nicely only on the right track' do
        result = monad(1,2)
        expect(result).to eq(Dry::Monads::Left('wrong'))
      end

      specify 'The fmap can be executed nicely only on the right track' do
        result = monad(2,1)
        expect(result).to eq(Dry::Monads::Right(20))
        expect(result.success?).to be_truthy
        expect(result.failure?).to be_falsy
        expect(result.right?).to be_truthy
        expect(result.left?).to be_falsy
      end
    end

    class EitherCalculator
      include Dry::Monads::Either::Mixin

      attr_accessor :input

      def calculate
        i = Integer(input)

        Right(i).bind do |value|
          if value > 1
            Right(value + 3)
          else
            Left("value was less than 1")
          end
        end.bind do |value|
          if value % 2 == 0
            Right(value * 2)
          else
            Left("value was not even")
          end
        end
      end
    end

    specify 'goes ok to right' do
      c = EitherCalculator.new
      c.input = 3
      expect(c.calculate).to eq(Dry::Monads::Right(12))
    end

    context 'left track' do
      specify 'left 1' do
        c = EitherCalculator.new
        c.input = 1
        expect(c.calculate).to eq(Dry::Monads::Left('value was less than 1'))
      end

      specify 'left 2' do
        c = EitherCalculator.new
        c.input = 2
        expect(c.calculate).to eq(Dry::Monads::Left('value was not even'))
      end      
    end
  end

  context 'maybe' do
    specify 'doubles' do
      array = [1,2,3,4,5]
      expect(M.Maybe(array).fmap{|x|x.map{|y|y*2}}).to eq(Dry::Monads::Some(array.map{|x|x*2}))
      expect(M.Maybe(nil).fmap{|x|x.map{|y|y*2}}).to eq(Dry::Monads::None())
    end

    specify 'returns the content if there is some' do
      expect(M.Maybe(2)).to eq(Dry::Monads::Some(2))
    end

    specify 'returns None there is none' do
      expect(M.Maybe(nil)).to eq(Dry::Monads::None())
    end

    specify 'value or something' do
      expect(M.Maybe(nil).value_or(2)).to eq(2)
    end

    context 'some operations' do
      specify '- with some or a value' do
        a = M.Maybe(2)
        b = M.Maybe(nil).or(0)
        expect(a.fmap{|x|x-b}).to eq(Dry::Monads::Some(2))
      end

      specify '- with some and none' do
        a = M.Maybe(nil)
        b = M.Maybe(2)
        c = M.Maybe(3)
        expect(b.bind{|x|c.fmap{|cc|x+cc}}).to eq(Dry::Monads::Some(5))
        expect(b.bind{|x|c.fmap{|cc|cc+x}}).to eq(Dry::Monads::Some(5))
        expect(c.bind{|x|b.fmap{|cc|cc+x}}).to eq(Dry::Monads::Some(5))

        expect(a.bind{|x|c.fmap{|cc|cc+x}}).to eq(Dry::Monads::None())
        expect(c.bind{|x|a.fmap{|cc|cc+x}}).to eq(Dry::Monads::None())
      end

      specify '- with 3 additions' do
        zero = M.Maybe(nil)
        a = M.Maybe(1)
        b = M.Maybe(2)
        c = M.Maybe(3)

        expect(a.bind{|aa|b.bind{|bb| c.fmap{|cc|cc+aa+bb}}}).to eq(Dry::Monads::Some(6))
        expect(b.bind{|aa|a.bind{|bb| c.fmap{|cc|cc+aa+bb}}}).to eq(Dry::Monads::Some(6))
        expect(c.bind{|aa|a.bind{|bb| b.fmap{|cc|cc+aa+bb}}}).to eq(Dry::Monads::Some(6))
      end
    end

    specify 'value or other monad' do
      expect(M.Maybe(nil).or(M.Maybe('123')).value).to eq('123')
    end

    specify 'extracting the value from some' do
      val = 2
      expect(Dry::Monads::Some(val).value).to eq(val)
      expect(Dry::Monads::None()).to eq(Dry::Monads::None())
    end

    context 'nesting' do
      let(:maybe_street) do
        maybe_street = M.Maybe(input).bind do |u|
          M.Maybe(u[:address]).bind do |a|
            M.Maybe(a[:street])
          end
        end
      end

      let(:input) { {address: {street: 'Park Slope 21'}} }
      let(:input_success) { input }
      let(:input_only_address) { {address: {city: 'NYC'}} }
      let(:input_empty) { {} }

      specify 'The output is the street' do
        expect(maybe_street.value).to eq(input[:address][:street])
      end

      context 'Street is missing' do
        let(:input) { input_only_address }

        specify 'The output is None' do
          expect(maybe_street.value).to be_nil
        end
      end

      context 'Address is missing' do
        let(:input) { input_empty }

        specify 'The output is None' do
          expect(maybe_street.value).to be_nil
        end
      end
    end

    context 'arythmethics' do
      specify 'nice' do
        add_two = -> (x) { M.Maybe(x + 2) }

        expect(M.Maybe(5).bind(add_two).bind(add_two).value).to eq(9)
        expect(M.Maybe(nil).bind(add_two).bind(add_two).value).to be_nil
      end
    end

    context 'or' do
      specify 'value or something else is value' do
        add_two = -> (x) { M.Maybe(x + 2) }

        expect(M.Maybe(5).bind(add_two).bind(add_two).or(M.Some(1)).value).to eq(9)
        expect(M.Maybe(nil).bind(add_two).bind(add_two).or(M.Some(1)).value).to eq(1)
      end
    end
  end

  context 'The most complex' do
    # let(:a)
    # let(:maybe){}
  end
end
