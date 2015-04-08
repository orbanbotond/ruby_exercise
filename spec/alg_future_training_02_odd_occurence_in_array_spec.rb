
def solution(a)
  pairs = {}
  a.each do |x|
    pairs[x] = pairs.fetch(x){0} + 1
  end

  odd = pairs.find{|x|x.last.odd?}
  odd.first
end

require 'spec_helper'

describe 'Odd occurences' do

  specify 'extreme small ones' do
    expect(solution([9, 3, 9, 3, 9, 7, 9])).to eq(7)
  end

end
