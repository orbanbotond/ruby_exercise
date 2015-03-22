def b_search(start_idx,end_idx, &block)
  return nil if end_idx < start_idx
  return start_idx if start_idx == end_idx
  middle = (start_idx + end_idx ) / 2
  comparison = yield( middle)
  return middle if comparison == 0
  if comparison < 0
    b_search(middle + 1, end_idx, &block)
  else
    b_search(start_idx, middle, &block)
  end
end

alias :to_check :b_search

require 'spec_helper'

describe 'binary search' do

  specify 'empty' do
    data = []
    expect(to_check(0, data.size - 1){|x|data[x] <=> 5 }).to eq(nil)
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