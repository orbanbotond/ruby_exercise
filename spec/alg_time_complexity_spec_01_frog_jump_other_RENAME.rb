require 'spec_helper'

describe 'Frog pass' do
  #TODO
  #redo 16% performance
  def a(x, a)
    timings = (1..x).to_a.map do |x|
      a.find_index{|leafe_position| leafe_position == x}
    end
    if timings.include? nil
      -1
    else
      timings.max
    end
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
