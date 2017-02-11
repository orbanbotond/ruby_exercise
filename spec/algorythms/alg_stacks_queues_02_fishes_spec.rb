# you can use puts for debugging purposes, e.g.
# puts "this is a debug message"

def do_debug str
    # puts str
end

def solution2(a, b)
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

def solution(a, b)
    do_debug "a:#{a} b:#{b}"
    input = [a, b].transpose
    downstream = []
    alive_upstream = 0

    input.each do |i|
        if i.last == 1 
            downstream.push(i)
            do_debug "downstream:#{downstream}"
        else
            while downstream.size > 0
                if downstream[-1].first > i.first
                    do_debug "downstream eats upstream"
                    break
                else
                    do_debug "upstream eats downstream"
                    downstream.pop
                end
            end
            if downstream.size == 0
                alive_upstream += 1 
                do_debug "upstream alive:#{alive_upstream}"
            end
        end
    end

    do_debug "alive_upstream:#{alive_upstream} downstream:#{downstream}"
    alive_upstream + downstream.size
end

  
def solution_nicest(a,b)
  fishes = [a,b].transpose
  remaining = []

  while fishes.size > 0 || remaining.size >= 2 && remaining[-1].last == 0 && remaining[-2].last == 1 do 
    if remaining.size >= 2 && remaining[-1].last == 0 && remaining[-2].last == 1
      if remaining[-1].first > remaining[-2].first
        remaining.delete_at -2
      else
        remaining.delete_at -1
      end
    elsif fishes.size > 0
      remaining.push fishes.shift
    end
  end

  remaining.size
end

require 'spec_helper'

#TODO efficiency: 25%
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
