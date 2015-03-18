def solution(s, p, q)
    impact_factor = { 'A' => 1, 'C' => 2, 'G' => 3, 'T' => 4 }
    query = [p, q].transpose
    impacts = []
    query.each do |q|
        impacts << s[q.first..q.last].chars.map{|nucleotid| impact_factor[nucleotid.upcase]}.min
    end
    impacts
    # write your code in Ruby 2.2
end

require 'spec_helper'

describe 'Minimum Missing Int' do
#TODO
#0%performance
  specify 'double element' do
    expect(solution('CAGCCTA', [2, 5, 0], [4, 5, 6])).to eq([2, 4, 1])
  end

end
