require 'spec_helper'

describe 'Equilibrum indexes' do
  def a(array)
    after_count = [0, array.first]
    before_count = [array.last, 0]
    array.each_cons(2) do |a,b|
      after_count << after_count.last + b
    end
    array.reverse_each.each_cons(2) do |a,b|
      before_count.unshift(before_count.first + b)
    end

    puts "after_count:#{after_count}"
    puts "before_count:#{before_count}"

    ret = []

    array.map.with_index do |o,idx|
      idx if before_count[idx] == after_count[idx + 1]
    end.compact
  end

  specify 'precision' do
    input_1 = [-1,3,-4,5,1,-6,2,1]
    expect([1,3,7]).to eq(a(input_1))
  end
end
