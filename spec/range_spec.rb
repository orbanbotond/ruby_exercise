require 'spec_helper'

describe "range" do

  context 'closed ends' do
    specify 'begining should be the first value' do
      expect((1...2).begin).to eql(1)
    end
    specify 'end should be the first value - step' do
      expect((1...2).end).to eql(2)
    end
    specify 'should exclude the end' do
      expect((1...2).exclude_end?).to be(true)
      expect((1..2).exclude_end?).to be(false)
    end
    specify 'dont include the last element' do
      expect(1...2).to_not include(2)
    end
    specify 'last element' do
      expect((1...2).last).to eq(2)
    end
    specify 'max' do
      expect((1...2).max).to eq(1)
    end
    specify 'to_a' do
      expect((1...4).to_a).to eq([1,2,3])
    end
    specify 'times include? raises and error' do
      expect { (Time.parse("1:00")...Time.now).include?(Time.parse("3:00")) }.to raise_error
    end
    specify 'times cover? works ok' do
      expect((Time.parse("1:00")...Time.now).cover?(Time.parse("4:00"))).to be(true)
    end
  end

end
