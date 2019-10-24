require 'spec_helper'

describe 'Tape Equilibrum' do

  #O(n)
  #space O(n)
  def solution(a)
    return 0 if a.max > a.size
    b = Array.new a.max, 0
    a.each do |elem|
      b[elem-1] += 1
    end
    b.all?{|x|x==1} ? 1:0
  end

  specify 'normal case' do
    expect(solution([4,1,3,2])).to eq(1)
  end

  specify 'negative case' do
    expect(solution([4,1,3])).to eq(0)
  end

end
