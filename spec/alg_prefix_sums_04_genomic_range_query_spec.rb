def solution(s, p, q)
    impact_factor = { 'A' => 1, 'C' => 2, 'G' => 3, 'T' => 4 }
    as_impact_factors = s.chars.map{|nucleotid| impact_factor[nucleotid.upcase]}
    query = [p, q].transpose
    impacts = []
    query.each do |q|
        impacts << as_impact_factors[q.first..q.last].min
    end
    impacts
    # write your code in Ruby 2.2
end

#[[2,4],[5,5],[0,6]]

# 0123456
# 2132241



require 'spec_helper'

describe 'Genomic Range Query' do
#TODO
#0%performance
  specify 'double element' do
    expect(solution('CAGCCTA', [2, 5, 0], [4, 5, 6])).to eq([2, 4, 1])
  end

end
