class User1
  def full_name
    "Johnnie Walker"
  end

  def self.add_rename
    alias :name :full_name
  end
end

class Developer1 < User1
  def full_name
    "Geeky geek"
  end

  add_rename
end

class User2
  def full_name
    "Johnnie Walker"
  end

  def self.add_rename
    alias_method :name, :full_name
  end
end

class Developer2 < User2
  def full_name
    "Geeky geek"
  end

  add_rename
end

require 'spec_helper'

describe 'The scope of alias is lexically scoped and alias_method is runtime scoped' do

  specify 'alias' do
    expect(Developer1.new.name).to eq('Johnnie Walker')
  end

  specify 'alias_method' do
    expect(Developer2.new.name).to eq('Geeky geek')
  end

end
