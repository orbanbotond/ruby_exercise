require 'spec_helper'

describe 'Max Counters' do

  #TODO correctness: 100%
  #     performance: 40%

  def a(n,a)
    counters = Array.new(n,0)
    a.each do |x|
        counters[x-1] +=1 if 1<=x && x<=n
        counters = Array.new(n, counters.max) if x==n+1
    end
    counters
  end

  specify 'double element' do
    expect(a(5,[3,4,4,6,1,4,4])).to eq([3,2,2,4,2])
  end
end
