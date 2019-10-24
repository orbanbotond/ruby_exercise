require 'spec_helper'

describe 'Missing Integer' do
  # def do_debug
  #   # debugging = true
  #   debugging = false
  #   yield if debugging
  # end
  # #O(n)
  # #space O(n)
  # def solution(a)
  #   do_debug{puts "a:#{a}"}
  #   b = {}
  #   a.each do |x|
  #     b[x] = true if x > 0
  #   end
  #   do_debug{puts "b:#{b}"}
  #   last = 0
  #   if b.keys.size > 0
  #     1.upto(b.keys.max) do |x|
  #       return x unless b[x]
  #       last = x
  #     end
  #   end
  #   last + 1
  # end

  # A[0] = 1
  # A[1] = 3
  # A[2] = 6
  # A[3] = 4
  # A[4] = 1
  # A[5] = 2

  # A[0] = -1 = > 1
  def solution(a)
    b = {}
    a.each { |x| b[x] = x if x >= 0 }

    last = 1
    while b.has_key?(last)
      last +=1
    end
    return last
  end

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

  specify 'negative against memory allocation' do
    input = [-2147483648, 2147483647]
    expect(solution(input)).to eq(1)
  end
end
