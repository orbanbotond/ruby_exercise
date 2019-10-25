require 'spec_helper'

describe 'problem 01' do

  def solve(n)
    string_representation = n.to_s
    reversed = string_representation.reverse!.chars
    final = []
    reversed.each_slice(3) do |x|
      final << x.join
    end
    final.join(',').reverse
  end

  specify 'test 01' do
    expect(solve(1)).to eq('1')
  end

  specify 'test 02' do
    expect(solve(10)).to eq('10')
  end

  specify 'test 03' do
    expect(solve(100)).to eq('100')
  end

  specify 'test 04' do
    expect(solve(1000)).to eq('1,000')
  end

  specify 'test 05' do
    expect(solve(10000)).to eq('10,000')
  end

  specify 'test 06' do
    expect(solve(100000)).to eq('100,000')
  end

  specify 'test 07' do
    expect(solve(1000000)).to eq('1,000,000')
  end

  specify 'test 07' do
    expect(solve(35235235)).to eq('35,235,235')
  end

end
