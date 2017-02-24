def rgb2hex_manual_cache(rgb)
  @rgb2hex ||= Hash.new do |colors, value|
    colors[value] = value.map { |e| "%02x" % e }.join
  end
  @rgb2hex[rgb]
end

def hex2rgb_manual_cache(hex)
  @hex2rgb ||= Hash.new do |colors, value|
    r,g,b = value[0..1], value[2..3], value[4..5]
    colors[value] = [r,g,b].map { |e| e.to_i(16) }
  end
  @hex2rgb[hex]
end

require 'spec_helper'

describe 'Memoization' do
  specify 'memoized fuctions using hash and code block in constructor to calculate themselves' do
    expect(hex2rgb_manual_cache('FFAA11')).to eq([255, 170, 17])
    expect(rgb2hex_manual_cache([255,64,18])).to eq('ff4012')
  end
end
