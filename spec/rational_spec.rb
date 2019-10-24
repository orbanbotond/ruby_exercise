require 'spec_helper'

describe 'Mathn' do

  specify 'precision' do
    expect((2r**72) / ((2r**70) * 3)).to eq(4r/3)
  end

end
