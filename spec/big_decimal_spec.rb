require 'bigdecimal'
require 'spec_helper'

describe 'BigDecimal' do

  specify 'precision' do
    sum = BigDecimal.new("0")
    10_000.times do
      sum = sum + BigDecimal.new("0.0001")
    end
    expect(sum).to eq(1)
  end

  specify 'inprecision' do
    sum = 0
    10_000.times do
      sum = sum + 0.0001
    end
    expect(sum).to_not eq(1)
  end

end
