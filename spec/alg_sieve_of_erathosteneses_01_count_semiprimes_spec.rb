def sieve_of_erathosteneses(n)
  array = Array.new n+1, 0
  i = 2
  while(i*i <= n) do
    if (array[i] == 0)
      k = i * i
      while (k <= n) do
        array[k] = i if (array[k] == 0)
        k += i
      end
    end
    i += 1 
  end
  array[0] = 1
  array[1] = 1
  return array
end

def factorize(x, sieve)
  primeFactors = []
  while (sieve[x] > 0)
    primeFactors << sieve[x]
    x /= sieve[x]
  end
  primeFactors << x
  return primeFactors
end

# a = sieve(20)
# puts "a:#{a}"
# a = sieve(26)
# puts "a:#{a}"
# sieve = a
# factorization(a,sieve)

def do_debug
  # debugging = true
  debugging = false
  puts(yield) if debugging
end

def solution_slow(n, p, q)
  do_debug{ "input:#{n} p:#{p} q:#{q}" }
  sieve = sieve_of_erathosteneses(n)
  query = [p,q].transpose
  answer = []

  query.each do |x|
    semiprime_count = 0
    (x.first).upto(x.last) do |potential_semiprime|
      factors = factorize(potential_semiprime, sieve)
      semiprime_count +=1 if factors.count == 2
      do_debug{ "found a semiprime:#{potential_semiprime}" }
      do_debug{ "incrementing semiprime_count: #{semiprime_count}" }
    end
    answer << semiprime_count
    do_debug{ "answer so far:#{answer}" }
  end

  do_debug{ "answer:#{answer}" }
  answer
end

# O(n^2)
def semiprimes(n, sieve)
  semi = []
  i = 2
  while(i*i <= n) do
    if (sieve[i] == 0)
      k = i * i
      while (k <= n) do
        semi << k if k % i == 0 && sieve[k / i] == 0
        k += 1
      end
    end
    i += 1 
  end
  semi
end

# time: O(N*log(log(N))+M);
# space: O(N+M),
#--------------------------
# sieve: O(N*log(log(N)))
# all semiprimes: O(n*n) ??
# prefix for semiprimes: O(nlog(n))
# diff: O(1)
def solution_slow_2(n, p, q)
  sieve = sieve_of_erathosteneses(n)
  # puts "sieve:#{sieve}"
  semi = semiprimes(n, sieve)
  # puts "sp:#{semi}"
  prefix = [0,0,0,0,1]
  5.upto(n) do |x|
    if semi.include? x 
      prefix << prefix.last + 1
    else
      prefix << prefix.last
    end
  end
  # puts "prefix:#{prefix}"

  queries =  [p,q].transpose


  res = queries.map do |query|
    prefix[query.last] - prefix[query.first - 1]
  end

  # puts "res:#{res}"

  res
end

# time: O(N*log(log(N))+M);
# space: O(N+M),
#--------------------------
# sieve: O(N*log(log(N)))
# all semiprimes: < O(N*log(log(N)))
# prefix for semiprimes: O(n)
#result O(m)
# diff: O(1)

def solution(n, p, q)
  primes = primes(n)
  # puts "primes:#{primes}"
  semi_primes_count = Array.new n+1, 0
  primes.each do |p1|
    primes.each do |p2|
      break if p1 * p2 > n
      semi_primes_count[p1 * p2] = 1
    end
  end

  1.upto(n) do |i|
    semi_primes_count[i] += semi_primes_count[i - 1]
  end

  queries =  [p,q].transpose

  res = queries.map do |query|
    semi_primes_count[query.last] - semi_primes_count[query.first - 1]
  end

  # puts "res:#{res}"

  res
end

def primes(n)
  sieve = sieve_of_erathosteneses(n)
  sieve.map.with_index{ |x, idx| x == 0 ? idx : nil}.compact
end

require 'spec_helper'

describe 'count the block wrapping the peaks' do

  specify 'simple' do
    expect(solution(26, [1,4,16], [26,10,20])).to eq([10,4,0])
  end

end
