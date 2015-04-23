require 'spec_helper'

describe 'Count Multiplicative Pairs' do

  def solution(a, b)
    data = [a, b].transpose
    c = data.map{|x|x.first + x.last/1000000.0}

    count = 0
    c.combination(2).to_a.each do |x|
      count += 1 if x.first * x.last >= x.first + x.last
    end

    [count, 1000000000].min
  end

  specify 'normal case' do
    expect(solution([0,1,2,2,3,5],[500000, 500000, 0, 0, 0, 20000])).to eq(8)
  end

end
