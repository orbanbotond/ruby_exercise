def caterpillarMethod(a, s)
  n = a.size
  front, total = 0, 0
  0.upto(n-1) do |back|
    while (front < n and total + a[front] <= s) do
      total += a[front]
      front += 1
    end
    return true if total == s
    total -= a[back]
  end
  return false
end

require 'spec_helper'

describe 'Caterpillar base' do

  specify 'normal case' do
    expect(caterpillarMethod([6,2,7,4,1,3,6], 12)).to be(true)
  end

end
