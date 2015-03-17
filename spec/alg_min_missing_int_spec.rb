require 'spec_helper'

describe 'Minimum Missing Int' do

  #TODO correctness: 80%
  #     performance: 75%

  def a(a)
    # a = a.sort.uniq
    a = a.uniq
    ((1..a.length).to_a - a).first
  end

  specify 'double element' do
    expect(a([1,3,6,4,1,2])).to eq(5)
  end

  specify 'large element' do
    input = (1..100000).to_a
    input[99999] = 100001
    expect(a(input.shuffle)).to eq(100000)
  end

  specify 'single' do
    expect(a([2])).to eq(1)
  end
end
