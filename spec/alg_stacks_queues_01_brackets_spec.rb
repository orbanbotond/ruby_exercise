# you can use puts for debugging purposes, e.g.
# puts "this is a debug message"

def solution_nicer(s)
  stack = []

  pairs ={'[' => ']', '{' => '}', '(' => ')'}

  s.chars.each do |x|
    if pairs.keys.include?  x
      stack << pairs[x]
    elsif stack.pop != x
      return 0
    end
  end
  stack.size == 0 ? 1 : 0
  # 1 nested
  # 0 otherwise
end

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

#([)()] => 0
#{[()()]} => 1

require 'spec_helper'

describe 'Alg Brackets' do

  specify 'empty' do
    expect(solution('')).to eq(1)
  end

  specify '1p' do
    expect(solution('()')).to eq(1)
  end

  specify '2p' do
    expect(solution('[]')).to eq(1)
  end

  specify '3p' do
    expect(solution('{}')).to eq(1)
  end

  specify '1n' do
    expect(solution('{(')).to eq(0)
  end

  specify '2n' do
    expect(solution('{]')).to eq(0)
  end

  specify 'normal negative test' do
    expect(solution('([)()]')).to eq(0)
  end

  specify 'normal pozitive test' do
    expect(solution('{[()()]}')).to eq(1)
  end

end
