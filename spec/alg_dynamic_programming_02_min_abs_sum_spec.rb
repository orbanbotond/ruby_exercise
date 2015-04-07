# you can use puts for debugging purposes, e.g.
# puts "this is a debug message"

def do_debug
  # debugging = true
  debugging = false
  puts yield if debugging
end

#TODO 20%performance
def solution(a)
  return 0 if a.size == 0
  n = a.size - 1
  a.map!{|x|x.abs}
  m = a.max
  s = a.reduce(:+)
  dp = Array.new s+1, 0
  dp[0] = 1

  0.upto(n) do |j|
    s.downto(0) do |i|
      dp[i + a[j]] = 1 if (dp[i] == 1) && (i + a[j] <= s)
    end
  end

  result = s

  0.upto(s/2) do |i|
    if dp[i] == 1
      result = [result, s - 2 * i].min
    end
  end

  result
end

require 'spec_helper'

describe 'Min Abs Sum Spec' do

  specify 'example' do
    expect(solution([1,5,2,-2])).to eq(0)
  end
  specify 'example1' do
    expect(solution([3,1])).to eq(2)
  end
  specify 'example2' do
    expect(solution([2,4,1])).to eq(1)
  end
  specify 'example3' do
    expect(solution([7,2])).to eq(5)
  end
  specify 'example4' do
    expect(solution([10, 11, 12, 13, 14])).to eq(6)
  end
  specify 'empty' do
    expect(solution([])).to eq(0)
  end
  specify 'example5' do
    expect(solution([-100, 3, 2, 4])).to eq(91)
  end

end
