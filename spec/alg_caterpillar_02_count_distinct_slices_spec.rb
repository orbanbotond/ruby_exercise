#TODO This algorithm gives 20% performance only 60% in total
def solution_non_preformant(a)
  puts "a:#{a}"

  beg_ind = 0
  end_ind = beg_ind
  count = 0

  while true do
    while (true) do
      count +=1
      if end_ind < a.size - 1
        if a[beg_ind..end_ind].include? a[end_ind+1]
          # puts "not able"
          break
        else
          # puts "e:#{end_ind + 1}"
          end_ind += 1
        end
      else
        # puts "not able"
        break
      end
    end
    beg_ind += 1
    break if beg_ind == a.size
    end_ind = beg_ind
  end

  count
end

#This algorythm uses n! four counting
def solution(a)
  accessed = Array.new(a.size + 1, nil)
  back = 0
  count = 0

  a.each_with_index do |x, idx|
    if accessed[x] == nil
      accessed[x] = idx
    else
      new_back = accessed[x] + 1
      count += (idx - back) * (idx - back + 1) / 2
      count -= (idx - new_back) * (idx - new_back + 1) / 2
      back.upto(new_back - 1) { |n| accessed[a[n]] = nil}
      accessed[x] = idx
      back = new_back
    end
  end

  count += (a.size - back) * (a.size - back + 1) / 2
end

require 'spec_helper'

describe 'Count distinct slices' do

  specify 'example test' do
    # input = [3,5,4,5,2]
    input = [3,4,5,5,2]
    expect(solution(input)).to eq(9)
  end

  specify 'example test' do
    input = [5,5,5,5,5]
    expect(solution(input)).to eq(5)
  end

  specify 'example test' do
    input = [1,5,5,5,5]
    expect(solution(input)).to eq(6)
  end

  specify 'simple' do
    input = [1, 3, 4, 1, 2, 1, 3, 2, 1]
    expect(solution(input)).to eq(24)
  end

  specify 'simple' do
    input = [2, 3, 3, 3, 2, 4, 1, 2, 5, 1, 4, 5, 1, 4]
    expect(solution(input)).to eq(37)
  end

  specify 'simple' do
    input = [5, 6, 10, 5, 6, 6, 2, 6, 7, 8, 1, 4, 1, 9, 7, 1, 10, 10, 7, 7, 2, 1, 6, 1, 2, 3, 1, 5, 5, 9, 6, 7, 5, 7, 5, 3, 10, 10, 9, 8, 4, 3, 3, 1, 8, 5, 9, 4, 10, 9, 1, 3, 10, 5, 10, 4, 1, 7, 8, 3, 1, 4, 10, 8, 2, 3, 2, 1, 8, 2, 6, 5, 2, 8, 2, 7, 2, 5, 3, 3, 10, 9, 4, 9, 3, 4, 9, 7, 2, 10, 3, 3, 8, 4, 3, 1, 1, 6, 3, 7]
    expect(solution(input)).to eq(335)
  end

end
