require 'spec_helper'

describe 'Equilibrum indexes' do

  def solution(a)
    # 0 ≤ P < Q < R < N;
    # [A[P], A[P+1], ..., A[Q]] decreasing
    # A[Q], A[Q+1], ..., A[R] increasing
    # depth min{A[P] − A[Q], A[R] − A[Q]}.
    diffs = []
    a[0..-2].each_cons(2) do |x,y|
      diffs << y - x
    end

    1.upto(diffs.size - 1) do |idx|
      if diffs[idx] > 0 && diffs[idx - 1] > 0 ||
        diffs[idx] < 0 && diffs[idx - 1] < 0
          diffs[idx] += diffs[idx - 1]
      end
    end

    bigest_depth = -1
    bigest_local_negative = nil
    bigest_last_negative = nil
    diffs.each do |x|
      bigest_last_negative = bigest_local_negative = x if x < 0 && (bigest_local_negative.nil? || bigest_local_negative > x)
      if x > 0 && bigest_last_negative
        bigest_local_negative = nil
        local_depth = [bigest_last_negative.abs, x].min
        bigest_depth = local_depth if bigest_depth < local_depth
      end

    end
    bigest_depth
  end

  specify 'normal case' do
    expect(solution([0,1,3,-2,0,1,0,-3,2,3])).to eq(4)
  end
  specify 'normal case' do
    expect(solution([0,1,3,-2,0,1,0,-3,2,3,4])).to eq(4)
  end
  specify 'no pits' do
    expect(solution([0,1,2])).to eq(-1)
  end
  specify 'no pits 2' do
    expect(solution([2, 1, 0])).to eq(-1)
  end
  specify 'no pits 2' do
    expect(solution([1, 1, 1])).to eq(-1)
  end
  specify 'empty' do
    expect(solution([])).to eq(-1)
  end
  specify 'one elem' do
    expect(solution([1])).to eq(-1)
  end
end
