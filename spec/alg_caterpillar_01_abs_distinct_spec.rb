def solution_using_lib(a)
  a.map{|x|x.abs}.uniq.count
end

def solution(a)
  beg_ind = 0
  end_ind = a.size - 1

  a = a.map!{|x|x.abs}
  count = 1
  current = [a[beg_ind], a[end_ind]].max

  while beg_ind <= end_ind do
    first = a[beg_ind]
    last = a[end_ind]

    if first == current
      beg_ind +=1
      next
    end
    if last == current
      end_ind -=1
      next
    end
    if first >= last
      current = first
      beg_ind += 1
    else
      current = last
      end_ind -= 1
    end
    count +=1
  end

  count
end

require 'spec_helper'

describe 'Abs distinct' do

  specify 'one element' do
    input = [1]
    expect(solution(input)).to eq(1)
  end

  specify 'normal case' do
    input = [-5,-3,-1, 0, 3, 6]
    expect(solution(input)).to eq(5)
  end

  specify 'mirror' do
    input = [-2, -2]
    expect(solution(input)).to eq(1)
  end

  specify '100' do
    input = [-100, -100, -100]
    expect(solution(input)).to eq(1)
  end

  specify 'tricky' do
    input = [-3, -1, 1, 2]
    expect(solution(input)).to eq(3)
  end

  specify 'simple no negative' do
    input = [ 1, 2]
    expect(solution(input)).to eq(2)
  end

  specify 'simple no negative2' do
    input = [0, 1, 2, 3, 4, 5, 6, 7, 100, 100, 200, 3000]
    expect(solution(input)).to eq(11)
  end

  specify 'simple no positive' do
    input = [ -3, -2, -1, 0]
    expect(solution(input)).to eq(4)
  end

  specify 'simple no positive 2' do
    input = [-100, -5, -4, -3, -2, -1, -1, 0, 0]
    expect(solution(input)).to eq(7)
  end

end
