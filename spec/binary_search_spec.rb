
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

def boards1(a, max_number_of_boards)
  b = 1
  e = a.size
  result = -1
  while (b <= e)
    mid = (b + e) / 2
    puts "checking: #{mid}"
    if count_necessary_boards(a, mid) <= max_number_of_boards
      e = mid - 1
      result = mid
    else
      b = mid + 1
    end
  end
  result
end

def count_necessary_boards(a, length)
  boards = 0
  last = -1
  a.each_with_index do |x, idx|
    if x == 1 and last < idx 
      boards += 1
      last = idx + length - 1
    end
  end
  puts "minimum boards:#{boards} length:#{length}"
  return boards
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

  specify 'boards 1' do
    data = [1,0,1,0,1]
    expect(boards1(data, 4)).to eq(1)
  end

  # specify 'boards 2' do
  #   data = [1,0,1,0,1]
  #   expect(boards2(data, 4)).to eq(1)
  # end

  # specify 'boards 3' do
  #   data = [1,0,1,0,1]
  #   expect(boards3(data, 4)).to eq(1)
  # end

end
