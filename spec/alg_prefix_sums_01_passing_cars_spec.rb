require 'spec_helper'

def solution(a)
    west_count = 0
    east_count = 0
    passings = 0

    a.each do |x|
        if x == 1
            west_count +=1
            #passings = passings + east_count
            passings = passings + east_count
        else
            east_count +=1
            #passings = passings + west_count
            # passings = passings + west_count
        end
        
    end

    passings > 1000000000 ? -1 : passings
end

require 'spec_helper'

describe 'Passing Cars' do

  specify 'double element' do
    expect(a([0,1,0,1,1])).to eq(5)
  end
end
