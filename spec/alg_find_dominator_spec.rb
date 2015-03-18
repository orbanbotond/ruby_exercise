# you can use puts for debugging purposes, e.g.
# puts "this is a debug message"

def solution(a)
    b = Array.new a.size, [0, 0]

    a.each do |x|
        b[x][0] += 1
        b[x][1] = x
    end

    dominator = b.find{|x| x.first > (a.size / 2)}
    dominator != nil ? a.find_index(dominator.last) : -1
    # write your code in Ruby 2.2
end

require 'spec_helper'

describe 'Find Dominator' do
  specify 'simple' do
    expect(solution([2, 1, 1] )).to eq(1)
  end

  specify 'sophisticated' do
    expect(solution([3, 4, 3, 2, 3, -1, 3, 3] )).to eq(0)
  end

end
