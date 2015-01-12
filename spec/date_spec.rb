require 'spec_helper'

describe 'Date' do
  specify 'ordinal' do
    d = Date.ordinal 2015, 1
    expect(d.day).to eq(1)
    expect(d.month).to eq(1)
    d = Date.ordinal 2015, 32
    expect(d.day).to eq(1)
    expect(d.month).to eq(2)
  end
  specify 'commercial' do
    d = Date.new 2015, 1, 1
    cwday = d.cwday
    d = Date.commercial 2015, 1, 7
    expect(d.day).to eq(7 - cwday + 1)
    expect(d.month).to eq(1)
    d = Date.commercial 2015, 2, 7
    expect(d.day).to eq(2 * 7 - cwday + 1)
    expect(d.month).to eq(1)
    d = Date.commercial 2015, 6, 7
    expect(d.day).to eq(8)
    expect(d.month).to eq(2)
  end
  specify 'yday' do
    d = Date.new 2015, 2, 1
    day = d.yday
    expect(day).to eq(32)
  end
end
