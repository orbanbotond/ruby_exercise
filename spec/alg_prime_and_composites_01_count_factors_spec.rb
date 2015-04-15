require 'spec_helper'

def solution_nicer(n)
  a  = 1
  b = n/a
  factors = 0
  while  a <= b do
    if a*b == n
      if a == b
        factors += 1
      else
        factors += 2
      end
    end
    a += 1
    b = n/a
  end   
  factors
    # write your code in Ruby 2.2
end

def solution(a)
  factor_count = 0

  last_factor = 1
  while last_factor*last_factor < a do
    if a % last_factor == 0
      factor_count += 2
    end
    last_factor += 1
  end

  factor_count +=1 if last_factor*last_factor == a

  return factor_count
end

require 'spec_helper'

describe 'factors count' do

  specify 'simple' do
    expect(solution(24)).to eq(8)
  end

  specify 'simple' do
    expect(solution(1)).to eq(1)
  end

  specify 'square' do
    expect(solution(9)).to eq(3)
  end

end
