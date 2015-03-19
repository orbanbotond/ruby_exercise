# you can use puts for debugging purposes, e.g.
# puts "this is a debug message"

def solution(a, b, k)
    d1 = a / k
    d1+=1 if d1*k < a
    d2 = b / k
    d2 - d1 + 1
    # write your code in Ruby 2.2
end

require 'spec_helper'

describe 'Count dividers' do
  # correctness: 100%
  # performance: 0%

  specify 'double element' do
    expect(solution(5, 8, 3)).to eq(1)
  end

end
