require 'spec_helper'

describe 'Tape Equilibrum' do
  #O(n)
  #space O(n)
  def solution_ugly(a)
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

  def solution(a)
    return a.first if a.size == 1
    max = a.reduce(:+)

    prefix = [0]
    a.each do |x|
      prefix << prefix.last + x
    end
    prefix.shift

    min = nil

    prefix[0..-2].each do |x|
      current_diff = (x - max + x).abs
      if min.nil? || min != nil && current_diff < min
        min = current_diff
      end
    end
    min
  end


  # 13
  # [3,1,2,4,3]
  # [0,0,0,0,0]
  # [0,3,4,6,10]

  specify 'normal case' do
    expect(solution([3,1,2,4,3])).to eq(1)
  end

  specify 'single element array' do
    expect(solution([1])).to eq(1)
  end

end
