require 'spec_helper'

#TODO
#Correctness: 100 %
#Perf: 80%
def solution(a)
    idx = 0
    min = nil

    core = ->(x,i) do
        sum = x.reduce(:+) / x.length.to_f
        # puts "Checking: slice: #{x}, idx: #{i} sum: #{sum}"
        if min == nil || min != nil && min > sum
            # puts "Setting as min!"
            idx = i
            min = sum
        end
    end

    a.each_cons(3).with_index do |x, i|
      core.call(x,i)
    end
    a.each_cons(2).with_index do |x, i|
      core.call(x,i)
    end

    idx
end

describe 'Min Avg Two Slice' do
  # correctness: 80%
  # performance: 0%

  specify 'double element' do
    expect(solution([4, 2, 2, 5, 1, 5, 8])).to eq(1)
  end
end
