require 'spec_helper'

# you can use puts for debugging purposes, e.g.
# puts "this is a debug message"
# O(n)
# O(1)
#
def solution(a)
  space = Array.new a.size + 1, 0
  a.each do |x|
    space[x-1] = 1
  end
  space.find_index(0) + 1
end

require 'spec_helper'

describe 'Perm missing element' do

  specify 'simple 1' do
    expect(solution([1,2,4])).to eq(3)
  end

  specify 'simple 2' do
    expect(solution([4,2,1])).to eq(3)
  end

  specify 'just one array' do
    expect(solution([2])).to eq(1)
  end

end
