
def solution(a)
  similars = {}
  a.each do |x|
    similars[x] = similars.fetch(x){0} + 1
  end

  odd = similars.find{|x|x.last.odd?}
  odd.first
end

require 'spec_helper'

describe 'Odd occurences' do

  specify 'extreme small ones' do
    expect(solution([9, 3, 9, 3, 9, 7, 9])).to eq(7)
  end

end
