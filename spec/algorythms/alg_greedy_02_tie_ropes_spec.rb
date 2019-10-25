require 'spec_helper'

describe 'tie ropes' do

  # you can use puts for debugging purposes, e.g.
  # puts "this is a debug message"

  def solution(k, a)
    # puts "k:#{k}, a:#{a}"
    tied = 0
    count = 0

    a.each do |rope|
      if rope >= k
        count +=1
        tied = 0
      else
        tied += rope
        if tied >= k
          count +=1
          tied = 0
        end
      end
    end

    count
  end

  specify 'normal case' do
    expect(solution(4, [1, 2, 3, 4, 1, 1, 3])).to eq(3)
  end

  specify 'empty' do
    expect(solution(4, [])).to eq(0)
  end

  specify '' do
    expect(solution(4, [1])).to eq(0)
  end

end
