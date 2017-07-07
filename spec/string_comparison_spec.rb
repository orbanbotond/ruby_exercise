require 'spec_helper'
require 'timeout'

describe 'Search Comparisons' do

  specify 'comparisons' do
    begining = Time.now
    1000.times do
      'avalami' =~/val/
    end
    d1 = Time.now - begining
    begining = Time.now
    1000.times do
      /val/.match 'avalami'
    end
    d2 = Time.now - begining
    begining = Time.now
    1000.times do
      'avalami'.include? 'val'
    end
    d3 = Time.now - begining
    expect(d3).to be < d2
    expect(d2).to be < d1
  end
end
