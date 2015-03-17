require 'spec_helper'

describe 'Equilibrum indexes' do
  #TODO
  #check the performance again
  def a(array)
    (1..array.length-1).map do |x|
      before_arr = array[0..(x-1)]
      after_arr = array[x..array.length-1]
      before_reduced = before_arr.reduce(:+)
      after_reduced = after_arr.reduce(:+)
      diff = (before_reduced - after_reduced).abs
    end.min
  end

  specify 'normal case' do
    a([1,2,3])
  end

end
