require 'spec_helper'

describe 'Binary gap' do

  def solution(a)
    return -1 if a.size.even? 
    b = 0
    e = a.size - 1
    while b <= e do
      if a[b] == a[e]
        b += 1
        e -= 1
      else
        return -1
      end
    end
    b - 1
  end

  specify 'ex 1' do
    expect(solution("racecar")).to eq(3)
  end

  specify 'ex 2' do
    expect(solution("x")).to eq(0)
  end

  specify 'exxeptional' do
    expect(solution("xx")).to eq(-1)
  end

  specify 'ex 3' do
    expect(solution("none")).to eq(-1)
  end

end
