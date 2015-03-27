
def b_search(start_idx,end_idx, &block)
    result = -1
    while (start_idx <= end_idx) do
      mid = (start_idx + end_idx) / 2
      if yield(mid) < 0
        start_idx = mid + 1 
      else
        end_idx = mid - 1
        result = mid
      end
    end
    return result
end

alias :to_check :b_search

require 'spec_helper'

describe 'binary search' do

  specify 'empty' do
    data = []
    expect(to_check(0, data.size - 1){|x|data[x] <=> 5 }).to eq(-1)
  end

  specify 'one elem' do
    data = [5]
    expect(to_check(0, data.size - 1){|x|data[x] <=> 5 }).to eq(0)
  end

  specify 'simple search' do
    data = [2,3,5,8,11]
    expect(to_check(0, data.size - 1){|x|data[x] <=> 5 }).to eq(2)
  end

  specify 'simple search' do
    data = [2,3,5,8,11,12]
    expect(to_check(0, data.size - 1){|x|data[x] <=> 8 }).to eq(3)
  end

end