# you can use puts for debugging purposes, e.g.
# puts "this is a debug message"

def solution(a)

    b = {}

    a.each do |x|
        if b[x]
            b[x] = b[x] + 1
        else
            b[x] = 1
        end
    end

    dominator = b.to_a.find{|x| x.last > (a.size / 2)}
    dominator != nil ? a.find_index(dominator.first) : -1
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
