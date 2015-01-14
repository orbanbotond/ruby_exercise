require 'spec_helper'
require 'set'

describe 'Set' do

  let(:set) { [1,2].to_set }
  let(:set_2) { Set.new [1,2] }
  let(:subset) { [1].to_set }
  let(:superset) { [1,2,3].to_set }

  specify 'two sets are equal' do
    expect(set).to eq(set_2)
  end

  specify 'does not add an already existing element into the set' do
    expect(set << 2).to eq(set_2)
  end

  specify 'adds a new element to the set' do
    expect(set << 3).to eq([1,2,3].to_set)
  end

  specify 'subset comparison' do
    expect(set <= superset).to be(true)
  end

  specify 'superset comparison' do
    expect(superset >= set).to be(true)
  end

  specify 'intersection' do
    expect(superset.intersection set).to eq(Set[1,2])
  end

  specify 'difference' do
    expect(superset - set).to eq(Set[3])
  end

end
