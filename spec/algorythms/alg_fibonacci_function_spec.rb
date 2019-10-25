require 'spec_helper'

describe 'Fibonacci multiplied functions' do

  def last_two_fibonacci(steps)
    prev_0 = 0
    prev_1 = 1
    steps.times do
      prev_0, prev_1 = [prev_1, prev_1 + prev_0]
    end
    [prev_0, prev_1]
  end

  def solution(a, b, n)
    fib_1, fib2 = last_two_fibonacci(n + 1)
    a*fib2 + b*fib_1
  end

  specify 'unit 1_1' do
    expect(solution(1, 2, 5)).to eq(29)
  end

end
