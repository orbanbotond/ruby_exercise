require 'spec_helper'

describe 'Minimum sum for k slices' do

  def solve(n, s, d, m)
      # Complete this function
      #m distance
      #d the sum

      buffer  = [0]
      s.each do |x|
          buffer << buffer.last + x
      end

      count = 0
      buffer.each_with_index do |x, idx|
          count += 1 if x - buffer[idx - m] == d
      end
      count
  end

  specify 'simple' do
    expect(solve(1,[4],4,1)).to eq(1)
  end

  specify 'simple' do
    expect(solve(6,[1,1,1,1,1,1],3,2)).to eq(0)
  end

  specify 'simple' do
    expect(solve(5,[1,2,1,3,2],3,2)).to eq(2)
  end
end
