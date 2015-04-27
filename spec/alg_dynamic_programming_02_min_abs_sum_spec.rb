# you can use puts for debugging purposes, e.g.
# puts "this is a debug message"

# you can use puts for debugging purposes, e.g.
# puts "this is a debug message"
# (n^2logn)
def solution_bad(a)
  return 0 if a.size == 0
  puts "a:#{a}"
  a.map!{|x|x.abs}
  while(a.size >= 2)
    a.sort!
    puts "a:#{a}"
    c = []
    while(a.size >= 2)
      b1 = a.pop
      b2 = a.shift
      c.push (b1 - b2).abs
    end
    a.concat c
  end
  a.first
end

# [5,1,2,-2]

# [1,2,2,5] | sum=10
#      x

# result = 10
#  0 1 2 3 4 5 6 7 8 9 0
# [1,1,1,1,1,1,1,1,1,1,1]
# 10, 10 - 2*5 = 10 = 0


# [2,2,5] sum = 9 diff = 1

# result = 9
#  0 1 2 3 4 5 6 7 8 9
# [1,0,1,0,1,1,0,1,0,1]

# 9/2 = 4
# min(9, 9-4) = 5
# min(9, 9-4*1) = min(9,1) = 1

def do_debug
  # debugging = true
  debugging = false
  puts yield if debugging
end

#TODO 20%performance
def solution_b(a)
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
    expect(solution([5,1,2,-2])).to eq(0)
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
  specify 'example6' do
    expect(solution([3,3,3,4,5])).to eq(0)
  end

end
