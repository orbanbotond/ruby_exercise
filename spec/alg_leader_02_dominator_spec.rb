# you can use puts for debugging purposes, e.g.
# puts "this is a debug message"

def solution2(a)
    candidate = nil
    candidate_last_idx = 0
    candidate_count = 0
    a.each_with_index do |x, idx|
        if candidate_count == 0
            candidate = x
            candidate_last_idx = idx
            candidate_count += 1
        elsif x == candidate
            candidate_count += 1
        else
            candidate_count -= 1
        end
    end

    leader_count = a.count{|x|x == candidate}
    if leader_count > a.size/2
        return a.find_index(candidate)
        # return candidate_last_idx
    else
        return -1
    end
end

def solution1(a)

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

alias :solution :solution2
# alias :solution :solution1

require 'spec_helper'

describe 'Find Dominator' do
  specify 'simple' do
    expect(solution([2, 1, 1] )).to eq(1)
  end

  specify 'sophisticated' do
    expect(solution([3, 4, 3, 2, 3, -1, 3, 3] )).to eq(0)
  end

end
