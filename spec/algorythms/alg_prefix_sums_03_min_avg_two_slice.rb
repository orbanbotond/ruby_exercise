require 'spec_helper'

def do_debug
  # debugging = true
  debugging = false
  yield if debugging
end

def solution(a)
    do_debug{puts "a: #{a}"}
    idx = 0
    min = nil

    core = ->(x,i) do
        sum = x.reduce(:+) / x.length.to_f
        do_debug{puts "Checking: slice: #{x}, idx: #{i} sum: #{sum}"}
        if min == nil || min != nil && min > sum
            do_debug{ puts "Setting as min!: #{sum} at idx:#{i}" }
            idx = i
            min = sum
        end
    end

    a.each_cons(2).with_index do |x, i|
      core.call(x,i)
    end
    a.each_cons(3).with_index do |x, i|
      core.call(x,i)
    end

    idx
end

describe 'Min Avg Two Slice' do

  specify 'double element' do
    expect(solution([4, 2, 2, 5, 1, 5, 8])).to eq(1)
  end

  specify 'big' do
    a = [-1, -1, 0, -1, 1, -1, 0, -1, 1, -1, 0, 0, -1, -1, 0, -1, 0, -1, -1, 0, 1, -1, -1, 1, -1, 1, 0, -1, 1, 1, 0, 1, -1, 0, 0, 1, -1, 0, 1, 0, 1, 0, 0, 1, 0, 1, 0, -1, 1, -1, 1, 1, 0, -1, 0, 0, -1, 0, 0, 0, -1, -1, 0, -1, 0, -1, 0, 1, 1, 0, 1, 1, 0, -1, 0, -1, 1, 0, 1, -1, -1, -1, -1, 0, -1, 0, 0, -1, -1, 0, -1, 0, -1]
    expect(solution(a)).to eq(0)
  end
end
