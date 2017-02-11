require 'spec_helper'

#space o(1)
def golden_solution(a)
  max_edge = max_slice = 0
  a.each_cons(2) do |x,y|
    profit = y - x
    max_edge = [0, max_edge + profit].max
    max_slice = [max_edge, max_slice].max
  end

  max_slice
end

# space: o(n)
def solution(a)
  b = a.each_cons(2).map{|x,y|y-x}
  max_sum = 0
  max_slice = 0
  b.each do |x|
    max_sum = [0, max_sum + x].max
    max_slice = [max_slice, max_sum].max
  end
  max_slice
end

# testing ruby combination method
def solution(a)
  max_profit = 0
  (0..a.size - 1).to_a.combination(2).to_a.each do |x|
    profit = a[x.last] - a[x.first]
    max_profit = profit if max_profit < profit
  end
  max_profit
end

require 'spec_helper'

describe 'Max profit' do

  specify 'double element' do
    a = [23171, 21011, 21123, 21366, 21013, 21367]
    expect(solution(a)).to eq(356)
  end
end
