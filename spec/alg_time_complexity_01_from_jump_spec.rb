# you can use puts for debugging purposes, e.g.
# puts "this is a debug message"

def solution(x, y, d)
    delta = y - x
    jumps = delta / d
    jumps * d < delta ? jumps + 1 : jumps
end

require 'spec_helper'

describe 'Frog pass' do

  specify 'simple' do
    expect(solution(10,40,30)).to eq(1)
  end

  specify 'need to jump one more' do
    expect(solution(10, 85, 30)).to eq(3)
  end

end
