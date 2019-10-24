require 'spec_helper'

describe 'Minimum sum for k slices' do

  def blocksNo(a, maxBlock)
    blocksNumber = 1
    preBlockSum = a[0]

    a[1..-1].each do |element|
      if preBlockSum + element > maxBlock
          preBlockSum = element
          blocksNumber += 1
      else
          preBlockSum += element
      end
    end
    return blocksNumber
  end

  def solution(k, m, a)
    lower = a.max
    upper = a.reduce(:+)
    result = 0
    while lower <= upper
      middle = (lower + upper) / 2
      slice_nr = blocksNo(a, middle)
      if slice_nr <= k
        upper = middle - 1
        result = middle
      else
        lower = middle + 1
      end
    end
    return result
  end

  specify 'simple' do
    expect(solution(3,5,[2,1,5,1,2,2,2])).to eq(6)
  end

end
