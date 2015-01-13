require 'mathn'
require 'spec_helper'

describe 'Mathn' do

  specify 'precision' do
    expect((2**72) / ((2**70) * 3)).to eq(4/3)
  end

end
