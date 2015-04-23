require 'spec_helper'

def solution(a)
  n = a.size
  a.unshift -1
  count = 0

  count = 0
  pos = (n + 1) / 2
  candidate = a[pos]
  1.upto(n + 1) do |i|
    count += 1 if a[i] == candidate
  end
  return candidate if (2*count > n)
    
  return -1
end

require 'spec_helper'

describe 'Sorted Leader' do

  specify 'positive test' do
    expect(solution([1,1,1,2,3])).to eq(1)
  end
  specify 'negative test' do
    expect(solution([2,2,2,2,2,3,4,4,4,6])).to eq(-1)
  end
end
