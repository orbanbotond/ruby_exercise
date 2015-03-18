# you can use puts for debugging purposes, e.g.
# puts "this is a debug message"

def solution(a)
    exists = false
    (0..(a.size-3)).each do |p|
        ((p+1)..(a.size-2)).each do |q|
            ((q+1)..(a.size-1)).each do |r|
                if a[p] + a[q] > a[r] && a[q] + a[r] > a[p] && a[r] + a[p] > a[q]
                    exists = true
                    return 1
                end
            end
        end
    end
    return 0
    # write your code in Ruby 2.2
end

require 'spec_helper'

#TODO
# Detected time complexity: O(N**3)
describe 'Detect triangle' do
  #TODO
  #check the performance again

  specify 'normal case' do
    expect(solution([10, 2, 5, 1, 8, 20] )).to eq(1)
  end

end
