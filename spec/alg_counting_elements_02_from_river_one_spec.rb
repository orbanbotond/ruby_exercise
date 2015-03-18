require 'spec_helper'

describe 'Frog pass' do
  def a(x, a)
    b = Array.new x, nil

    a.each_with_index do |pos, time|
      b[pos-1] = time if b[pos-1] == nil
    end

    b.all?{|x|x != nil} ? b.max : -1
  end

  specify 'single element' do
    expect(a(1,[1])).to eq(0)
  end

  specify 'double element' do
    expect(a(5,[1,3,1,4,2,3,5,4])).to eq(6)
  end

  specify 'cannot pass' do
    expect(a(5, [1,3,1,4,2,4,4,3])).to eq(-1)
  end

  specify 'cannot pass' do
    expect(a(5, [1,6,1,4,2,4,4,5])).to eq(-1)
  end

end
