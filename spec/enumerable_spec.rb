require 'spec_helper'

describe 'Enumerable' do
  context 'collect_concat' do
    specify 'returns the flat' do
      expect([1,2,3].collect_concat{|x|[x*2,x*3]}).to eql([2,3,4,6,6,9])
    end
  end
  context 'collect' do
    specify 'creates an array and puts the transformed item in it' do
      expect([1,2].collect{|x|x*2}).to eql([2,4])
    end
  end
  context 'chunk' do
    specify 'consecutive elements with the same return value are chunked together' do
      expect([1,2,4,3,5,6].chunk{|x|x.even?}.to_a).to eq([[false,[1]],[true, [2,4]],[false, [3,5]],[true, [6]]])
    end
  end
  context 'all?' do
    specify 'checks all the items in the enumberale' do
      expect([1,2,nil].all?).to be(false)
    end
    specify 'checks all the items in the enumberale' do
      expect([1,2,3].all?).to be(true)
    end
    specify 'checks all the items in the with block' do
      expect([1,2,3].all?{|x|x.odd?}).to be(false)
    end
    specify 'checks all the items in the with block' do
      expect([1,2,3].all?{|x|x.even?}).to be(false)
    end
  end
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