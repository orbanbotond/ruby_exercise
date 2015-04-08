
def solution(a)
  b = a.to_s(2)
  longest = 0
  longest_temp = 0
  b.chars.each_cons(2) do |x,y|
    if x == "1" && y == "0"
      longest_temp = 1
    elsif x == "0" && y == "0"
      longest_temp += 1
    elsif x == "0" && y == "1"
      longest = longest_temp if longest < longest_temp
    end
  end

  longest
end

require 'spec_helper'

describe 'Binary gap' do

  specify 'ex 1' do
    expect(solution(1041)).to eq(5)
  end

  specify 'ex 2' do
    expect(solution(15)).to eq(0)
  end

  specify 'ex 3' do
    expect(solution(20)).to eq(1)
  end

  specify 'ex 4' do
    expect(solution(9)).to eq(2)
  end

end
