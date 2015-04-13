# you can use puts for debugging purposes, e.g.
# puts "this is a debug message"


def solution_nicest(a)
  return 0 if a.size < 3
  a.sort!
  a.each_cons(3) do |x,y,z|
    return 1if x + y > z
  end
  return 0
end

def solution(a)
    if a.size < 3
      return 0
    else
      a.sort!
      exists = false
      (0..(a.size-3)).each_with_index do |e, i|
        if a[i] + a[i+1] > a[i+2]
          return 1
        end
      end
      return 0
    end
    # write your code in Ruby 2.2
end

require 'spec_helper'

describe 'Detect triangle' do

  specify 'normal case' do
    expect(solution([10, 2, 5, 1, 8, 20] )).to eq(1)
  end

end
