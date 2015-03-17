require 'spec_helper'

describe 'Passing Cars' do
  # correctness: 40%
  # performance: 0%
  def a(a)

    min_idx = 100001
    average = 10000000
    # a.slice_when {|i, j| i < j }.to_a
    (2..(a.size-1)).each do |slice_size|
        a.each_cons(slice_size).with_index do |slice, idx|
            avg = slice.reduce(:+)/2.0
            if avg < average
                average = avg
                min_idx = idx
            end
        end
    end
    min_idx

  end

  specify 'double element' do
    expect(a([4, 2, 2, 5, 1, 5, 8])).to eq(1)
  end
end
