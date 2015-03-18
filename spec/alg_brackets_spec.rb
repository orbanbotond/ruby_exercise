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
    return 1
    # write your code in Ruby 2.2
end

#([)()] => 0
#{[()()]} => 1

require 'spec_helper'

#TODO
#Correctness: 33%
#Performance: 80%

# Detected time complexity: O(N**3)
describe 'Alg Brackets' do
  #TODO
  #check the performance again

  specify 'normal negative test' do
    expect(solution('([)()]')).to eq(0)
  end

  specify 'normal pozitive test' do
    expect(solution('{[()()]}')).to eq(1)
  end

end
