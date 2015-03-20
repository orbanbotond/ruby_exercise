require 'spec_helper'

def solution(a)
    dominant_left_row = a.max - a.min + 1
    dominant_right_row = a.max - a.min + 2
    h = Array.new a.size + 1, Array.new( a.max - a.min + 3, 0)
    a.each_with_index do |x, col|
        row = x - a.min
        h[col + 1] = h[col].dup
        h[col + 1][row] = h[col][row] + 1
    end
    # puts "#{h}"
    a.each_index do |col|
        dominant_left = h[col + 1].max

        if h[col + 1].find_all{|x|x == dominant_left}.count > 1
            dominant_left = -1
        else
            dominant_left = h[col + 1].find_index(dominant_left)
        end
        h[col + 1][dominant_left_row] = dominant_left

        # right_side =  h.last.map.with_index{|x,i| x - h[1,i]}
        right_side =  h.last.map.with_index{|x,i| x - h[col + 1][i]}.to_a

        dominant_right = right_side.max
        # puts "dominant: #{dominant_right}"

        if right_side.find_all{|x|x == dominant_right}.count > 1
            dominant_right = nil
        else
            dominant_right = right_side.find_index(dominant_right)
        end
        h[col + 1][dominant_right_row] = dominant_right
    end
    h.count{|x| x[dominant_left_row] == x[dominant_right_row]} -1
end

# TODO
# Correctness: 60%
# Performance: 0%

require 'spec_helper'

describe 'Equi Leader' do

  specify 'solu 1' do
    #0 and #2 are equi leaders
    expect(solution([4,3,4,4,4,2])).to eq(2)
  end

end
