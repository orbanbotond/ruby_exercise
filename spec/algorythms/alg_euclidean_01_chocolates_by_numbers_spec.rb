require 'spec_helper'

describe 'Stone Wall' do

  # you can use puts for debugging purposes, e.g.
  # puts "this is a debug message"

  def solution(n,m)
    multiple = n.lcm m
    multiple/m
  end

  specify 'empty' do
    expect(solution(10, 4)).to eq(5)
  end

end
