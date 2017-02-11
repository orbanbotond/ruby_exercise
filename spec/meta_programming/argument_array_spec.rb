def do_that(*args)
  args.reduce(:+)
end

require 'spec_helper'

describe 'Collapse the list of arguments into an array' do

  specify 'array argument' do
    expect(do_that(2,3,5)).to eq(10)
  end

end
