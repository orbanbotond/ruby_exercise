require 'spec_helper'

def solution(a, m)
  count = 0

  a.combination(2).to_a.each do |x,y|
    if y-x % m == 0
      count += 1 
      puts "x:#{x} y:#{y}"
    end
  end

  count
end

describe 'Equilibrum indexes' do

  specify 'unit 4_2' do
    a = [-3, -2, 1, 0, 8, 7, 1]
    expect(solution(a, 3)).to eq(4)
  end

end