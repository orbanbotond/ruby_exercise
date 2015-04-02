# you can use puts for debugging purposes, e.g.
# puts "this is a debug message"

#TODO correctness: 0%
#     performance: 85%
def solution(a)
  # puts "a:#{a}"
  a.map!{|x| [x.abs, x < 0 ? -1 : 1] }
  a.sort!{|x,y| x.first <=> y.first }
  min = 20000000000
  a.each_cons(2) do |x,y|
    ab = (x.first * x.last + y.first * y.last).abs
    min = ab if ab < min
  end
  a.each do |x|
    ab = (x.first * x.last + x.first * x.last).abs
    min = ab if ab < min
  end
  min
  # write your code in Ruby 2.2
end

require 'spec_helper'

describe 'min abs sum of two' do

  specify 'normal case' do
    expect(solution([1, 4, -3, 5] )).to eq(1)
  end

  specify 'normal case' do
    expect(solution([1, 4, -3, -6, 8] )).to eq(1)
  end

  specify 'normal case' do
    expect(solution([-8, 8, -5, 2] )).to eq(0)
  end

  specify 'normal' do
    expect(solution([-8, -4, -5, -1] )).to eq(2)
  end

  specify 'normal' do
    expect(solution([-1000000000])).to eq(2000000000)
  end

  specify 'normal' do
    expect(solution([-1000000000, -999999999] )).to eq(1999999998)
  end

  specify 'all positive' do
    expect(solution([8, 5, 3, 4, 6, 8] )).to eq(6)
  end

  specify 'all negative' do
    expect(solution([-8, -5, -4, -10, -12, -18] )).to eq(8)
  end

end
