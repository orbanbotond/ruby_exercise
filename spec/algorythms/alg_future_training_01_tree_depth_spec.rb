require 'spec_helper'

describe 'Tree depth' do

  # you can use puts for debugging purposes, e.g.
  # puts "this is a debug message"

  def solution(a)
    if a.l.nil? && a.r.nil?
      0
    else
      d1 = d2 = 0
      d1 = 1 + solution(a.l) if a.l
      d2 = 1 + solution(a.r) if a.r
      d1 > d2 ? d1 : d2
    end
  end

  class Tree
    attr_accessor :x, :l, :r

    def initialize( x, l, r)
      self.x = x
      self.l = l
      self.r = r
    end
  end

  specify 'extreme small ones' do
    t = Tree.new(5, Tree.new(3, Tree.new(20, nil, nil), Tree.new(21, nil, nil)), Tree.new(10, Tree.new(1, nil, nil), nil))
    expect(solution(t)).to eq(2)
  end

  specify 'extreme small zeros' do
    t = Tree.new(5, Tree.new(3, Tree.new(20, nil, Tree.new(12, nil, Tree.new(25, nil, nil))), Tree.new(21, nil, nil)), Tree.new(10, Tree.new(1, nil, nil), nil))
    expect(solution(t)).to eq(4)
  end


end
