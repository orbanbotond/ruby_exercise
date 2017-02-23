require 'spec_helper'
require 'benchmark'

describe 'Map' do

  def map_simple(array, &block)
    array.each_with_object([]) { |e, arr| arr << yield(e) }
  end

  def map_recursive(array, &block)
    return [] if array.empty?
    [ yield(array[0]) ] + map_recursive(array[1..-1], &block)
  end

  def map_side_effect_less_non_recursive(array, &block) 
    array.inject([]) { |accumulator, iterated| [ yield(iterated) ] + accumulator }
  end

  specify 'simple' do
    expect(map_simple([1,2,3]){|x| 2 * x}).to eq([2,4,6])
  end

  specify 'side effect less map' do
    expect(map_recursive([1,2,3]){|x| 2 * x}).to eq([2,4,6])
  end

  specify 'side effect less map non recursive' do
    expect(map_side_effect_less_non_recursive([1,2,3]){|x| 2 * x}).to eq([2,4,6])
  end

  specify 'recursive map take more time x1.6' do
    b1 = Benchmark.measure do
        1000000.times { map_simple([1,2,3]){|x| 2 * x} }
    end
    b2 = Benchmark.measure do
        1000000.times { map_recursive([1,2,3]){|x| 2 * x} }
    end
    expect(b2.total / b1.total).to be_within(0.5).of(1.6)
  end

  specify 'recursive vs non recursive' do
    b1 = Benchmark.measure do
        1000000.times { map_side_effect_less_non_recursive([1,2,3]){|x| 2 * x} }
    end
    b2 = Benchmark.measure do
        1000000.times { map_recursive([1,2,3]){|x| 2 * x} }
    end
    expect(b2.total / b1.total).to be_within(0.5).of(1.0)
  end

  specify 'recursive map takes the same space' do
    1000000.times { map_simple([1,2,3]){|x| 2 * x} }
    obj1 = ObjectSpace.count_objects[:TOTAL]

    1000000.times { map_recursive([1,2,3]){|x| 2 * x} }
    obj2 = ObjectSpace.count_objects[:TOTAL]
    expect(obj1*1.0 / obj2).to be_within(0.5).of(1.0)
  end
end
