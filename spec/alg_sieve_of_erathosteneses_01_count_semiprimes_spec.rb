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

def solution(n, p, q)
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

require 'spec_helper'

#TODO
#performance: 40%
describe 'count the block wrapping the peaks' do

  specify 'simple' do
    expect(solution(26, [1,4,16], [26,10,20])).to eq([10,4,0])
  end

end
