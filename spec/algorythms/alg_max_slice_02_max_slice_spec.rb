require 'spec_helper'

describe 'Max slice' do

  def my_solution(a)
    max_edge = max_slice = -1000000
    a.each do |x|
      max_edge = [x, max_edge + x].max
      max_slice = [max_edge, max_slice].max
    end

    max_slice
  end

  def solution(a)
    max_sum = a.first
    max_slice = a.first
    a[1..-1].each do |x|
      max_sum = [x, max_sum + x].max
      max_slice = [max_slice, max_sum].max
    end
    max_slice
  end

  specify 'double element' do
    a = [3, 2, -6, 4, 0]
    expect(solution(a)).to eq(5)
  end

  specify 'negative one element' do
    a = [-6]
    expect(solution(a)).to eq(-6)
  end

  specify 'negative two elements' do
    a = [-6, -4]
    expect(solution(a)).to eq(-4)
  end
end
