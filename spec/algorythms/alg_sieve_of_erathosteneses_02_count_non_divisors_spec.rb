require 'spec_helper'

#TODO 0% performance
#O(n(sqrt(n)))
describe 'count the block wrapping the peaks' do

  #O(nlog(log(n)))
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

  # O(n)
  def factorize(x, sieve)
    primeFactors = []
    while (sieve[x] > 0)
      primeFactors << sieve[x]
      x /= sieve[x]
    end
    primeFactors << x
    return primeFactors
  end

  #O(sqrt(n))
  class Integer
    def factors
      1.upto(Math.sqrt(self)).select {|i| (self % i).zero?}.inject([]) do |f, i| 
        f << self/i unless i == self/i
        f << i
      end.sort
    end
  end

  def do_debug
    # debugging = true
    debugging = false
    puts(yield) if debugging
  end

  #TODO perf: 75%
  def solution(a)
    max = a.max
    map = {}
    a.each do |x|
      map[x] = 0
    end

    a.each do |x|
      k = 1
      while k * x <= max
        actual = k*x
        map[actual] += 1 if map.has_key? actual
        k += 1
      end
    end
    n = a.size
    a.map{|x|n - map[x]}
  end

  def solution_slow(a)
    do_debug{"a:#{a}"}
    max = a.max
    # sieve = sieve_of_erathosteneses(max)

    # b = a.map{|x|factorize(x,sieve)}

    result = a.map do |x|
      do_debug{"-!Checking:#{x}!-"}
      factors = x.factors
      do_debug{"a:#{a} f:#{factors}"}
      non_dividors = (a - factors)
      do_debug{"non dividors are: #{non_dividors} count:#{non_dividors.count}"}
      non_dividors.count
    end

    do_debug{"result:#{result}"}

    result
  end

  specify 'simple' do
    expect(solution([3,1,2,3,6])).to eq( [2, 4, 3, 2, 0] )
  end

  specify 'simple' do
    expect(solution([6, 7, 2, 1, 4, 7, 4, 4, 1, 8, 10, 15])[-3]).to eq( 5 )
  end

end
