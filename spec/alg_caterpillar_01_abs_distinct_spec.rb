
def solution(a)
  a.map{|x|x.abs}.uniq.count
end

require 'spec_helper'

describe 'Abs distinct' do

  specify 'normal case' do
    input = [-5,-3,-1, 0, 3, 6]
    expect(solution(input)).to be(5)
  end

end
