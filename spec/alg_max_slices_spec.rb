# you can use puts for debugging purposes, e.g.
# puts "this is a debug message"

def solution(a)

    max = 0

    (0..(a.size-3)).each do |x|
        ((x+1)..(a.size-2)).each do |y|
            ((y+1)..(a.size-1)).each do |z|
                slices = a.find_all.with_index{|xx, idx|((x < idx) && (idx < y)) || ((y < idx) && (idx < z))}
                sum = slices.reduce(:+) || 0
                #puts "Slice of: '#{x},#{y},#{z}' is: #{sum}"
                #puts "resolution : '#{slices.uniq}"

                max = sum if sum > max
            end
        end
    end
    max
    # write your code in Ruby 2.2
end

require 'spec_helper'

#TODO

describe 'Max slices' do

  specify 'normal case' do
    expect(solution( [3, 2, 6, -1, 4, 5, -1, 2] )).to eq(17)
  end

end
