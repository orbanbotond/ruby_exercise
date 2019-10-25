require 'spec_helper'

describe 'Array inversion count' do

  def mergesort(list)
    return [list, 0] if list.size <= 1
    mid = list.size / 2
    left  = list[0, mid]
    right = list[mid, list.size-mid]
    res_left = mergesort(left)
    res_right = mergesort(right)
    merge(res_left.first, res_right.first, res_right.last + res_left.last)
  end

  def merge(left, right, inversions)
    sorted = []
    until left.empty? or right.empty?
      if left.first <= right.first
        sorted << left.shift
      else
        inversions += left.size
        sorted << right.shift
      end
    end
    [sorted.concat(left).concat(right), inversions]
  end

  def solution(a)
    res, inversions = mergesort(a)
    inversions > 1000000000 ? -1 :  inversions
  end

  specify 'simple' do
    expect(solution([-1, 6, 3, 4, 7, 4])).to eq(4)
  end

  specify 'simple' do
    expect(solution([-1, 0, 1, 2, 3, 4])).to eq(0)
  end

  specify 'simple' do
    expect(solution([5, 4, 3, 2, 1, 0])).to eq(15)
  end

end
