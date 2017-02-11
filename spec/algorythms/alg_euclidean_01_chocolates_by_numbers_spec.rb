# you can use puts for debugging purposes, e.g.
# puts "this is a debug message"

def solution(n,m)
  multiple = n.lcm m
  multiple/m
end

require 'spec_helper'

describe 'Stone Wall' do

  specify 'empty' do
    expect(solution(10, 4)).to eq(5)
  end

end
