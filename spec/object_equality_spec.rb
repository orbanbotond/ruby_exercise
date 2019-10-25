require 'spec_helper'

describe "object equality" do
  before do
    A = Struct.new(:a) do
      def method_name
        
      end
    end

    create_temporary_class 'B', A do
      def initialize(a)
        super(a)
      end
    end

    create_temporary_class 'C' do
      def initialize(a)
        @a = a
      end
    end
  end

  context '==' do
    context 'custom class' do
      specify 'manual override ==' do
        class GNOT
          attr_reader :latitude, :longitude

          def initialize(latitude, longitude)
            @latitude, @longitude = latitude, longitude
          end
        end

        class G
          attr_reader :latitude, :longitude

          def initialize(latitude, longitude)
            @latitude, @longitude = latitude, longitude
          end

          def ==(other)
            other.is_a?(self.class) && latitude == self.latitude && longitude == self.longitude
          end
        end

        g1 = GNOT.new(1,2)
        g2 = GNOT.new(1,2)
        expect(g1).to_not eq(g2)
        
        g1 = G.new(1,2)
        g2 = G.new(1,2)
        expect(g1).to eq(g2)
      end

      specify 'using equalizer' do
        class G
          include Equalizer.new(:latitude, :longitude)

          attr_reader :latitude, :longitude

          def initialize(latitude, longitude)
            @latitude, @longitude = latitude, longitude
          end
        end

        g1 = G.new(1,2)
        g2 = G.new(1,2)

        expect(g1).to eq(g2)
      end
    end

    specify 'For struct it compares the attributes' do
      a1 = A.new(1)
      a12 = A.new(1)
      expect(a1 == a12).to be(true)
    end

    specify 'For regular class it compares the object itself' do
      c1 = C.new(1)
      c2 = C.new(2)
      expect(c1 == c2).to be(false)
      expect(c1 == c1).to be(true)
      expect(c2 == c2).to be(true)
    end
  end

  context 'equal?' do
    specify 'Identity comparison' do
      a1 = A.new(1)
      a12 = A.new(1)
      expect(a1.equal? a12).to be(false)
      expect(a1).to_not be_equal(a12)
      expect(a1).to be_equal(a1)
    end
  end

  context 'eql?' do
    specify 'Identity comparison' do
      a1 = 1
      a12 = 1.0
      expect(a1.eql? a12).to be(false)
      expect(a1).to_not be_eql(a12)
      expect(a1).to be_eql(a1)
    end
  end

  context 'hash' do
    specify 'calculates' do
      a1 = A.new(1)
      a12 = A.new(1)
      a22 = A.new(1.0)
      expect(a1.hash).to eq(a12.hash)
      expect(a1.hash).to_not eq(a22.hash)
    end

    specify 'nested' do
      a11 = A.new(1)
      a12 = A.new(a11)
      a21 = A.new(1.0)
      a22 = A.new(a21)

      expect(a12.hash).to_not eq(a22.hash)
    end
  end

  # context '==='
end
