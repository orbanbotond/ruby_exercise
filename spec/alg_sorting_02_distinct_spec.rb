
def solution1(a)
    a.uniq.size
end

def solution2(a)
    distinct_count = 0
    d = {}
    a.each do |x|
        unless d[x]
            d[x] = x
            distinct_count += 1
        end
    end

    distinct_count
end

alias :solution :solution2

require 'spec_helper'

describe 'Distinct' do

  specify 'normal case' do
    expect(solution([2,2,1,3,1,1])).to eq(3)
  end

end
