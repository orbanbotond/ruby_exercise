require 'spec_helper'

describe "pattern matching and destructuring" do

  Placeholder = Struct.new(:bindings, :name) do
    def ==(other)
      return false unless guards.all?{ |g| g === other }
      bindings[name] = other
      true
    end

    def guards
      @guards ||= []
    end

    def >>(guard)
      guards << guard
      self
    end
  end

  class MatchContext
    def initialize
      @bindings = Hash.new { |hash, key| Placeholder.new(hash, key) }
    end

    def method_missing(name, *)
      @bindings[name]
    end
  end

  Point = Struct.new(:x, :y)

  specify 'does not match the nil' do
    p = Point.new(5, nil)
    m = MatchContext.new
    expect(Point.new(m.x >> Integer, m.y >> Integer)).to_not be === p
  end

  specify 'does not match if any of the chain guards fail ...' do
    p = Point.new("a", 23)
    m = MatchContext.new
    expect(Point.new(m.x >> String >> /\d/, m.y >> Integer)).to_not be === p
  end

  specify 'passes if all chain guards passes' do
    p = Point.new("22", 23)
    m = MatchContext.new
    expect(Point.new(m.x >> String >> /\d/, m.y >> Integer)).to be === p
  end

end
