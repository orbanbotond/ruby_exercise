# you can use puts for debugging purposes, e.g.
# puts "this is a debug message"

def are_other_prime_divisors(x, common_prime_divisor)
  while x > 1
    gcd = x.gcd common_prime_divisor
    break if gcd == 1
    x /= gcd
  end
  x != 1
end

def has_same_prime_divisors(x,y)
  gcd = x.gcd y
  return false if are_other_prime_divisors(x,gcd)
  return false if are_other_prime_divisors(y,gcd)
  return true
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

  specify 'just one' do
    expect(solution([1], [1])).to eq(1)
  end

  specify 'wont pass' do
    expect(solution([2], [8])).to eq(1)
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
