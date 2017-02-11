# you can use puts for debugging purposes, e.g.
# puts "this is a debug message"

def generate_fibonacci(n)
  array = Array.new
  array << 0
  array << 1
  2.upto(n).each do |x|
    array << array[-1] + array[-2]
  end
  array
end

def solution(a, b)
  maximum = a.max
  fib = generate_fibonacci(maximum + 1)
  t = [a,b].transpose
  # puts "fib:#{fib} t:#{t}"
  t.map {|x| fib[x.first+1] % 2**x.last }
end

require 'spec_helper'

describe 'Ladder' do

  specify 'example' do
    expect(solution([4, 4, 5, 5, 1], [3, 2, 4, 3, 1])).to eq([5, 1, 8, 0, 1])
  end

end
