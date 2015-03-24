# you can use puts for debugging purposes, e.g.
# puts "this is a debug message"

def has_same_prime_divisors(x,y)
  smaller = [x,y].min
  bigger = [x,y].max
  if bigger % smaller == 0
    factor = bigger / smaller
    if bigger % factor == 0 && smaller % factor == 0
      true
    else
      false
    end
  else
    false
  end
end

def solution(a, b)
  t = [a,b].transpose
  t.count {|x| has_same_prime_divisors(x.first, x.last) }
end

require 'spec_helper'

describe 'Stone Wall' do

  specify 'empty' do
    expect(solution([15, 10, 3], [75, 30, 5])).to eq(1)
  end

  specify 'empty' do
    expect(solution([3, 9, 20, 11],[9, 81, 5, 13])).to eq(2)
  end

  specify 'empty' do
    expect(solution([2, 1, 2], [1, 2, 2])).to eq(1)
  end

  specify 'simple test with small values' do
    expect(solution([6059, 551],[442307, 303601])).to eq(2)
  end

  specify 'powers of prime' do
    expect(solution([121, 8, 25, 81, 49],[11, 4, 125, 11, 7])).to eq(4)
  end

  specify 'small primes' do
    expect(solution([7, 17, 5, 3],[7, 11, 5, 2])).to eq(2)
  end

end
