# you can use puts for debugging purposes, e.g.
# puts "this is a debug message"

def solution(s)
    a = []
    pairs = {'{' => '}', '[' => ']', '(' => ')'}
    s.chars.each do |c|
        if c == '{' || c == '[' || c == '('
            a.push c
        else
            return 0 if c != pairs[a.pop]
        end
    end
    if a.empty?
      return 1
    else
      return 0
    end
    # write your code in Ruby 2.2
end

require 'spec_helper'

describe 'Alg Brackets' do

  specify 'empty' do
    expect(solution('')).to eq(1)
  end

  specify '1p' do
    expect(solution('()')).to eq(1)
  end

  specify '2p' do
    expect(solution('(()(())())')).to eq(1)
  end

  specify '3n' do
    expect(solution('())')).to eq(0)
  end


end
