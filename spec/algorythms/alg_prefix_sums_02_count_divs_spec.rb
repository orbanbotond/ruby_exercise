require 'spec_helper'

describe 'Count dividers' do

  # you can use puts for debugging purposes, e.g.
  # puts "this is a debug message"

  def do_debug
    # debugging = true
    debugging = false
    yield if debugging
  end

  def solution_s(a, b, k)
      do_debug{ puts "a:#{a} | b:#{b} | k:#{k}"}
      d1 = a / k
      d1+=1 if d1*k < a
      d2 = b / k
      d2 - d1 + 1
      # write your code in Ruby 2.2
  end

  def solution(a, b, k)
    edge = (a % k == 0 )? 1 : 0
    return b/k - a/k + edge
  end

  specify 'double element' do
    expect(solution(5, 8, 3)).to eq(1)
  end

end
