def solution(a)
    product = nil
    (0..(a.size-3)).each do |p|
        ((p+1)..(a.size-2)).each do |q|
            ((q+1)..(a.size-1)).each do |r|
                value = a[p] * a[q] * a[r]
                product = value if product == nil || value > product
            end
        end
    end
    product
end
# write your code in Ruby 2.2

require 'spec_helper'

#TODO
# Detected time complexity:O(N**3)
# Expected O(log(N))

describe 'Equilibrum indexes' do

  specify 'normal case' do
    expect(solution([-3, 1, 2, -2, 5, 6])).to eq(60)
  end

end
