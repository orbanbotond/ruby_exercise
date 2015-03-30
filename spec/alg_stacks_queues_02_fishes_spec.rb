# you can use puts for debugging purposes, e.g.
# puts "this is a debug message"

def do_debug str
    # puts str
end

def solution(a, b)
    do_debug "a:#{a} b:#{b}"
    input = [a, b].transpose
    remainings = []

    input.each do |i|
        remainings.push i
        do_debug "remainings:#{remainings}"
        while remainings.size >= 2 &&
            remainings[-2].last == 1 &&
            remainings[-1].last == 0
            l1, l2 = remainings[-2..-1]
            do_debug "there are two fishes swiming toward each other"
            do_debug "l1:#{l1} l2:#{l2}"
            remainings.pop
            remainings.pop
            if l1.first > l2.first
                do_debug 'l1 eats l2'
                remainings.push l1
            else
                do_debug 'l2 eats l1'
                remainings.push l2
            end
        end
    end
    remainings.size
end

require 'spec_helper'

describe 'Greedy Fishes' do
  specify 'simple' do
    expect(solution([4,3,2,1,5],[0,1,0,0,0])).to eq(2)
  end

  specify 'sophisticated' do
    expect(solution([4,3,2,6,5],[0,1,0,1,0])).to eq(3)
  end

  specify 'simple one direction' do
    expect(solution([3,4],[1,1])).to eq(2)
  end

  specify 'simple one direction 2' do
    expect(solution([3,4],[0,0])).to eq(2)
  end

  specify 'just one' do
    expect(solution([3],[0])).to eq(1)
  end

  specify 'just one' do
    expect(solution([3],[1])).to eq(1)
  end

  specify 'simplest' do
    expect(solution([3,4],[1, 0])).to eq(1)
  end

  specify 'simplest2' do
    expect(solution([3,4],[0, 1])).to eq(2)
  end

  specify 'tricky' do
    expect(solution([8, 6, 5, 3, 2, 4, 7], [1, 1, 1, 1, 1, 0, 0])).to eq(1)
  end

end
