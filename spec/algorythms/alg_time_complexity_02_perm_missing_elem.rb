require 'spec_helper'

describe 'Perm missing element' do

  # you can use puts for debugging purposes, e.g.
  # puts "this is a debug message"
  # O(n)
  # O(n)
  #
  def solution_o_n_space(a)
    space = Array.new a.size + 1, 0
    a.each do |x|
      space[x-1] = 1
    end
    space.find_index(0) + 1
  end

  def solution(a)
    sum = a.reduce(:+)
    sum = 0 if sum.nil?
    size = a.size
    desired_sum = ((size + 1) * (size + 2))/2
    desired_sum - sum
  end

  specify 'single array' do
    expect(solution([2])).to eq(1)
  end

  specify 'empty list' do
    expect(solution([])).to eq(1)
  end

  specify 'simple 1' do
    expect(solution([1,2,4])).to eq(3)
  end

  specify 'simple 2' do
    expect(solution([4,2,1])).to eq(3)
  end

  specify 'just one array' do
    expect(solution([2])).to eq(1)
  end

end
