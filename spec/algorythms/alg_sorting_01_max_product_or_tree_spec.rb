require 'spec_helper'

describe 'Equilibrum indexes' do

  def update_maxes(x, maxes)
      if x > maxes[0]
          maxes[2] = maxes[1]
          maxes[1] = maxes[0]
          maxes[0] = x
      elsif x > maxes[1]
          maxes[2] = maxes[1]
          maxes[1] = x
      elsif x > maxes[2]
          maxes[2] = x
      end
  end

  def update_mins(x, mins)
      if x < mins[0]
          mins[1] = mins[0]
          mins[0] = x
      elsif x < mins[1]
          mins[1] = x
      end
  end

  def solution(a)
      maxes = [-1000, -1000, -1000]
      mins = [+1001, +1001]
      a.each do |x|
          update_maxes(x,maxes)
          update_mins(x,mins)
          # puts "x:#{x} |#{maxes}"
          # puts "x:#{x} |#{mins}"
      end
      p1 = maxes[0] * maxes[1] * maxes[2]
      p2 = maxes[0] * mins[0] * mins[1]
      [p1, p2].max
  end

  def solution2(a)
      #This will return 50%correctness + 40%performance
      a.sort
      a[-1] * a[-2] * a[-3]
  end
  # write your code in Ruby 2.2

  def solution_nicest(a)
    a.sort!

    v1 = a[0] * a[1] * a[-1]
    v2 = a[-1] * a[-2] * a[-3]
    v1 > v2 ? v1 : v2
  end

  specify 'normal case' do
    expect(solution([-3, 1, 2, -2, 5, 6])).to eq(60)
  end

end
