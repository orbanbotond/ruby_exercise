require 'spec_helper'

def solution(a)
  factor_count = 0

  last_factor = 1
  factors = [last_factor]
  while last_factor*last_factor < a do
    if a % last_factor == 0
      factors << last_factor
      factor_count += 2
    end
    last_factor += 1
  end

  if last_factor*last_factor == a
    factors << last_factor
  end

  min_perimeter = nil
  factors.each do |factor|
    width = a/factor
    height = factor
    temp_perimeter = width*2 + height * 2
    if min_perimeter == nil || min_perimeter &&  temp_perimeter < min_perimeter
      min_perimeter = temp_perimeter
    end
  end

  return min_perimeter
end

require 'spec_helper'

describe 'factors count' do

  specify 'simple' do
    expect(solution(30)).to eq(22)
  end

end
