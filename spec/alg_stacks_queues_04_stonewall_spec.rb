# you can use puts for debugging purposes, e.g.
# puts "this is a debug message"

def solution(a)
    count = 0
    stack = []

    a.each do |stone_high|
      while stack.last != nil && stack.last > stone_high do
        stack.pop
      end

      unless !stack.empty? && stack.last == stone_high
        stack << stone_high
        count += 1
      end
    end

    count
end

require 'spec_helper'

describe 'Stone Wall' do

  specify 'empty' do
    expect(solution([8,8,5,7,9,8,7,4,8])).to eq(7)
  end

end
