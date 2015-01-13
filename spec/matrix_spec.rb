require 'matrix'
require 'spec_helper'

describe 'Matrix' do

  specify 'multiplication' do
    m1 = Matrix[ [25, 93], [-1, 66], [3,4] ]
    m2 = Matrix[ [3,2,1], [3,4,1] ]
    expect { m1*2 }.not_to raise_error(Exception)
  end

end
