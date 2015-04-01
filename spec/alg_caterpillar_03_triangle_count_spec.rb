# you can use puts for debugging purposes, e.g.
# puts "this is a debug message"

def solution(a)
    if a.size < 3
      return 0
    else
      a.sort!
      count = 0
      size = a.size
      size -= 1

      0.upto(size) do |i|
        (i+1).upto(size) do |k1|
          (k1+1).upto(size) do |k2|
            count +=1 if a[i] + a[k1] > a[k2]
          end
        end
      end

      return count
    end
    # write your code in Ruby 2.2
end

require 'spec_helper'

describe 'count triangles' do

  specify 'normal case' do
    expect(solution([10, 2, 5, 1, 8, 12] )).to eq(4)
  end

end
