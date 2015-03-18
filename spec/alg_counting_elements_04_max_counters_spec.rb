require 'spec_helper'

  #TODO correctness: 100%
  #     performance: 40%

def solution(n,a)
  # initial_counters = Array.new(n,0)
  counters = Array.new(n,0)
  # increments = 0
  a.each do |x|
      counters[x-1] +=1 if 1<=x && x<=n
      counters = Array.new(n,counters.max) if x == n+1
      #   increments += counters.max
      #   counters = initial_counters
      # end
  end
  # counters.map{|x|x+increments}
  counters
end

describe 'Max Counters' do

  specify 'double element' do
    expect(solution(5,[3,4,4,6,1,4,4])).to eq([3,2,2,4,2])
  end
end
