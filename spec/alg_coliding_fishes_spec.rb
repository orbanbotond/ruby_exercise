# you can use puts for debugging purposes, e.g.
# puts "this is a debug message"

def solution(a, b)
    input = [a, b].transpose
    remainings = []

    input.each do |i|
        remainings.push i
        if remainings.size > 2
            l1, l2 = remainings[-2..-1]
            if l1.last == 1 && l2.last == 0
                remainings.pop
                remainings.pop
                if l1.first > l2.first
                    remainings.push l1
                else
                    remainings.push l2
                end
            end
        end
    end
    remainings.size
end

require 'spec_helper'

describe 'Greedy Fishes' do
#correctness: 50%, performance: 25%
  specify 'simple' do
    expect(solution([4,3,2,1,5],[0,1,0,0,0])).to eq(2)
  end

  specify 'sophisticated' do
    expect(solution([4,3,2,6,5],[0,1,0,1,0])).to eq(3)
  end

end
