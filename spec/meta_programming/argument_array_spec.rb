require 'spec_helper'

describe 'Collapse the list of arguments into an array' do

  def do_that(*args)
    args.reduce(:+)
  end

  specify 'array argument' do
    expect(do_that(2,3,5)).to eq(10)
  end

end
