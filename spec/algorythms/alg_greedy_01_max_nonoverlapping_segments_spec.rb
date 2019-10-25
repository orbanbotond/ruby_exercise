require 'spec_helper'

describe 'max nonoverlapping segments' do

  # you can use puts for debugging purposes, e.g.
  # puts "this is a debug message"

  def overlap(first_segment, last_segment)
    # puts "f:#{first_segment} l:#{last_segment}"
    if first_segment.first <= last_segment.first &&
      last_segment.first <= first_segment.last ||
      last_segment.first <= first_segment.first &&
      first_segment.first <= last_segment.last
      ret = true
    else
      ret = false
    end
    # puts "r:#{ret}"
    ret
  end

  def solution(a, b)
    c = [a,b].transpose
    # puts "c:#{c}"
    counted = []

    c.each do |segment|
      last = counted.last
      next if last && overlap(last, segment)
      counted << segment
      # puts "c:#{counted}"
    end
    counted.size
  end


  specify 'normal case' do
    expect(solution([1, 3, 7, 9, 9], [5, 6, 8, 9, 10])).to eq(3)
  end

  specify 'empty' do
    expect(solution([], [])).to eq(0)
  end

  specify 'every second' do
    expect(solution([11,22,33,44,55], [22,33,44,55,66])).to eq(3)
  end

end
