require 'spec_helper'

def preprocess()
  
end

def generate_key(word)
  word.chars.sort.join
end

def anagrams(input)
  keys = {}
  File.open('anagrams').each do |word|
    key = generate_key(word.strip)
    keys[key] = keys.fetch(key,[]) << word.strip
  end

  key = generate_key(input)
  keys[key]
end

describe 'anagrams' do

  specify 'test 01' do
    expect(anagrams('beat').sort).to eq(['beat', 'beta', 'bate'].sort)
  end

  specify 'test 02' do
    expect(anagrams('apple').sort).to eq(['appel', 'apple'].sort)
  end

  specify 'test 03' do
    expect(anagrams('reset').sort).to eq(['reset', 'steer', 'trees'].sort)
  end

end
