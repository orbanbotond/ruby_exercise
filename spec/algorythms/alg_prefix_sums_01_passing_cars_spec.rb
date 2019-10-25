require 'spec_helper'

describe 'Passing Cars' do

  def solution_nicer(a)
    counter = 0
    incrementer = 0
    a.each do |x|
      incrementer += 1 if x == 0
      counter += incrementer if x == 1
      return -1 if counter > 1000000000
    end
    counter
  end

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

  specify 'double element' do
    expect(solution_nicer([0,1,0,1,1])).to eq(5)
  end
end
