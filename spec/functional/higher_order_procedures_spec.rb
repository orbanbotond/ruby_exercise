require 'spec_helper'

describe 'Higher Order Procedures' do
  context '&obj calls the to_proc on the object' do
    context 'symbol' do
      class Symbol
        def to_proc
          lambda { |x| x.send(self) } 
        end
      end
      specify 'simple' do
        expect( %w[foo bar baz].map(&:capitalize)).to eq(['Foo', 'Bar', 'Baz'])
      end
    end
    context 'bigger object' do
      class Filter
        def initialize
          @constraints = []
        end
        def constraint(&block)
          @constraints << block
        end
        def to_proc
          lambda { |e| @constraints.all? { |fn| fn.call(e) } }
        end
      end

      specify "will filter for all constraint" do
        filter = Filter.new 
        filter.constraint { |x| x > 10 }
        filter.constraint { |x| x.even? }
        filter.constraint { |x| x % 3 == 0 }
        expect((8..24).select(&filter)).to eq([12,18,24])
        filter.constraint { |x| x % 4 == 0 }
        expect((8..24).select(&filter)).to eq([12,24])
      end
    end
  end
end
