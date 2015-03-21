require 'spec_helper'

def solution(a)
  factor_count = 2

  last_factor = 2
  while last_factor*last_factor < a do
    if a % last_factor == 0
      factor_count += 2
    end
    last_factor += 1
  end

  factor_count+=1 if last_factor*last_factor == a

  return factor_count
end

require 'spec_helper'

describe 'factors count' do

  specify 'simple' do
    expect(solution(24)).to eq(8)
  end

  specify 'square' do
    expect(solution(9)).to eq(3)
  end

end
