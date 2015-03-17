require 'spec_helper'

describe 'Permutation spec' do
  #Wrong twice elements are not considered
  def a(array)
    (1..array.length).to_a - array == [] ? 1 : 0
  end

# [1,2,2] - [1,2,3]

  specify 'double element' do
    expect(a([1,2,2])).to eq(0)
  end

  specify 'missing element' do
    expect(a([1,2,4])).to eq(0)
  end

  specify 'normal element' do
    expect(a([1,2,3])).to eq(1)
  end

end
