#TODO need to isolate this shit!!!

require 'spec_helper'

describe 'Memoization' do
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

  specify 'memoized fuctions using hash and code block in constructor to calculate themselves' do
    expect(hex2rgb_manual_cache('FFAA11')).to eq([255, 170, 17])
    expect(rgb2hex_manual_cache([255,64,18])).to eq('ff4012')
  end

  context 'Meta Reusable Memoization' do
    before do
      create_temporary_class 'Memoized' do
        def self.memoize( name, cache = Hash.new )
          original = "__unmemoized_#{name}__"
          ([Class, Module].include?(self.class) ? self : self.class).class_eval do 
            alias_method original, name
            private original
            define_method(name) { |*args| cache[args] ||= send(original, *args) }
          end
        end

        def rgb2hex(rgb)
          rgb.map { |e| "%02x" % e }.join
        end
        memoize :rgb2hex

        def hex2rgb(hex)
          r,g,b = hex[0..1], hex[2..3], hex[4..5] 
          [r,g,b].map { |e| e.to_i(16) }
        end
        memoize :hex2rgb
      end
    end

    specify 'memoized fuctions using our memo' do
      expect(Memoized.new.hex2rgb('FFAA11')).to eq([255, 170, 17])
      expect(Memoized.new.rgb2hex([255,64,18])).to eq('ff4012')
    end
  end
end
