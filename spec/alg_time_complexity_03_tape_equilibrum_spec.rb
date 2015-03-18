require 'spec_helper'

#O(n)
#space O(n)
def solution(a)
  sum = a.reduce(:+)
  b = Array.new a.size + 1, 0
  min = nil
  a.each_with_index do |elem, idx|
    if( idx != (a.size - 1))
      b[idx + 1] = b[idx] + elem
      before_sum = b[idx + 1]
      after_sum = sum - b[idx + 1]
      diff = (before_sum - after_sum).abs
      if min == nil || min!= nil && min > diff
        min = diff
      end
    end
  end
  min
end

# 13
# [3,1,2,4,3]
# [0,0,0,0,0]
# [0,3,4,6,10]

describe 'Tape Equilibrum' do

  specify 'normal case' do
    expect(solution([3,1,2,4,3])).to eq(1)
  end

end
