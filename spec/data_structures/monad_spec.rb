require 'spec_helper'

describe 'Monad' do
  context 'either' do
    context 'the main benefit' do

      M = Dry::Monads

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
    M = Dry::Monads

    specify 'returns the content if there is some' do
      expect(M.Maybe(2)).to eq(Dry::Monads::Some(2))
    end

    specify 'returns None there is none' do
      expect(M.Maybe(nil)).to eq(Dry::Monads::None())
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
end
