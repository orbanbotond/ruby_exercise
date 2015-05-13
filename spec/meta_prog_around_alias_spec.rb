# you can use puts for debugging purposes, e.g.
# puts "this is a debug message"

def do_that(arg)
  arg.reverse
end

alias :old_do_that :do_that

def do_that(arg)
  "X#{old_do_that(arg)}YY"
end

require 'spec_helper'

describe 'Call the previous method from the aliased version' do

  specify 'array argument' do
    expect(do_that('as')).to eq('XsaYY')
  end

end
