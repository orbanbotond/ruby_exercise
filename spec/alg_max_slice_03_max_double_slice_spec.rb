require 'spec_helper'

def solution(a)
    max_ending_here = Array.new a.size, 0
    max_ending_here_temp = 0
    1.upto(a.size - 1).each do |idx|
      x = a[idx]
      max_ending_here_temp = [0, x + max_ending_here_temp].max
      max_ending_here[idx] = max_ending_here_temp
    end

    max_beginning_here = Array.new a.size, 0
    max_beginning_here_temp = 0
    (a.size-2).downto(0) do |idx|
        x = a[idx]
        max_beginning_here_temp = [0, x + max_beginning_here_temp].max
        max_beginning_here[idx] = max_beginning_here_temp
    end 

    max_double_slice = 0
    0.upto(a.size - 3).each do |idx|
        max_double_slice = [max_double_slice, max_ending_here[idx] + max_beginning_here[idx+2]].max
    end

    return max_double_slice
end

require 'spec_helper'

describe 'Max slice' do

  specify 'one minus in middle' do
    a = [-1, -1, -1, -2, -1, -1, -1]
    expect(solution(a)).to eq(-1)
  end

  specify 'one minus in middle' do
    a = [-3, 2, 6, -1, 4, 5, 2]
    expect(solution(a)).to eq(19)
  end

  specify 'two minus in middle' do
    a = [3,2,6,-1,4,5,-1,2]
    expect(solution(a)).to eq(17)
  end

  specify 'double element' do
    a = [3, 2, 6, 5, 4, 5, 3, 2]
    expect(solution(a)).to eq(28)
  end

end
