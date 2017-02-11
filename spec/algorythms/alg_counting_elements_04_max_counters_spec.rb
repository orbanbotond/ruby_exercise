require 'spec_helper'

def solution(n,a)
  initial = Array.new(n,0)
  counters = Array.new(n,0)
  increments = 0
  max = 0
  a.each do |x|
      if 1<=x && x<=n
        counters[x-1] +=1
        max = counters[x-1] if max < counters[x-1]
      end
      if x == n+1
        increments += max
        max = 0
        counters = initial.dup
      end
  end
  counters.map{|x|x+increments}
  # counters
end

describe 'Max Counters' do

  specify 'double element' do
    expect(solution(5,[3,4,4,6,1,4,4])).to eq([3,2,2,4,2])
  end
end
