# you can use puts for debugging purposes, e.g.
# puts "this is a debug message"

def do_debug
  # debugging = true
  debugging = false
  puts yield if debugging
end

#
# Detected time complexity:
# O(N*log(N))
def solution(a)
  a.each_with_index do |elem, idx|
    next if idx ==0
    bidx = [idx - 6, 0].max
    last_6_max = a[bidx..(idx-1)].max
    a[idx] += last_6_max
    # puts "a:#{a}"
  end
  a[-1]
end

require 'spec_helper'

describe 'Frog Jumps' do

  specify 'extreme small ones' do
    expect(solution([1, -2, 0, 9, -1, -2])).to eq(8)
  end

  specify 'ensures tha last 6 max + actual' do
    expect(solution([1, -2, 9, 8, -3, -3, -3, -3, -2, -1])).to eq(17)
  end

end
