require 'spec_helper'

#O(n)
#space O(n)
def solution(a)
  b = Array.new a.size, nil
  a.each do |x|
    b[x - 1] = true if x > 0
  end
  idx = b.find_index{|x|x == nil} || a.max
  idx + 1
end

#TODO 
# Correctness:100%
# Performance: 40%
# Task score: 66%

describe 'Missing Integer' do

  specify 'normal case' do
    expect(solution([1,3,6,4,1,2])).to eq(5)
  end

  specify 'single missing' do
    expect(solution([2])).to eq(1)
  end

  specify 'single missing' do
    expect(solution([1])).to eq(2)
  end

  specify 'one negative' do
    expect(solution([-1, 2])).to eq(1)
  end

  specify 'just negative' do
    expect(solution([-1, -2])).to eq(1)
  end

end
