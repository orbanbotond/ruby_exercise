def solution(a)
    a.uniq.size
end

require 'spec_helper'

describe 'Distinct' do

  specify 'normal case' do
    expect(solution([-3, 1, 2, -2, 5, 6])).to eq(60)
  end

end
