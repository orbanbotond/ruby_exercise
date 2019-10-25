require 'spec_helper'

describe 'Dividable Pairs' do

  def solve(n, k, s)
    s.combination(2).to_a.select{|x|x.reduce(:+) % k == 0}.count
  end

  specify 'simple' do
    expect(solve(6, 3, [1, 3, 2, 6, 1, 2])).to eq(5)
  end
end
