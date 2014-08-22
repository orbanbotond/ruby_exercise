require 'spec_helper'

describe 'Enumerable' do
  context 'first' do
    specify 'returns the first element' do
      expect([1,2].first).to eql(1)
    end
    specify 'returns the first n element' do
      expect([1,2].first(2)).to eql([1,2])
    end
    specify 'returns the first n element' do
      expect([1,2].first(3)).to eql([1,2])
    end
    specify 'returns nil if empty' do
      expect([].first).to be_nil
    end
    specify 'returns blank array if n is specified' do
      expect([].first(2)).to be_empty
    end
  end
end