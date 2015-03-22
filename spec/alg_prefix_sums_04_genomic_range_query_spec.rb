def do_debug
  # debugging = true
  debugging = false
  yield if debugging
end

def solution(s, p, q)
    impact_factor = { 'A' => 1, 'C' => 2, 'G' => 3, 'T' => 4 }
    as_impact_factors = s.chars.map{|nucleotid| impact_factor[nucleotid.upcase]}
    next_occurence = Array.new(impact_factor.size + 1) { Array.new(s.size + 1, -1) }
    do_debug{puts "speed_matrix:#{next_occurence}"}

    as_impact_factors.to_enum.with_index.reverse_each do |x, idx|
        next_occurence[0][idx] = next_occurence[0][idx+1]
        next_occurence[1][idx] = next_occurence[1][idx+1]
        next_occurence[2][idx] = next_occurence[2][idx+1]
        next_occurence[3][idx] = next_occurence[3][idx+1]
        next_occurence[4][idx] = next_occurence[4][idx+1]
        next_occurence[x][idx] = idx
    end

    do_debug{puts "speed_matrix:#{next_occurence}"}

    query = [p, q].transpose
    impacts = []
    query.each do |q|
        do_debug{puts "checking f:#{q.first} l:#{q.last}"}
        do_debug{puts "checking 4: f:#{q.first <= next_occurence[4][q.first]} l:#{next_occurence[4][q.first] <= q.last}"}
        do_debug{puts "checking 3: f:#{q.first <= next_occurence[3][q.first]} l:#{next_occurence[3][q.first] <= q.last}"}
        do_debug{puts "checking 2: f:#{q.first <= next_occurence[2][q.first]} l:#{next_occurence[2][q.first] <= q.last}"}
        do_debug{puts "checking 1: f:#{q.first <= next_occurence[1][q.first]} l:#{next_occurence[1][q.first] <= q.last}"}
        m4 = m3 = m2 = m1 = nil
        m4 = 4 if q.first <= next_occurence[4][q.first] && next_occurence[4][q.first] <= q.last
        m3 = 3 if q.first <= next_occurence[3][q.first] && next_occurence[3][q.first] <= q.last
        m2 = 2 if q.first <= next_occurence[2][q.first] && next_occurence[2][q.first] <= q.last
        m1 = 1 if q.first <= next_occurence[1][q.first] && next_occurence[1][q.first] <= q.last
        do_debug{puts "m:#{[m1, m2, m3, m4].compact} min:#{[m1, m2, m3, m4].compact.min}"}
        impacts << [m1, m2, m3, m4].compact.min
    end
    do_debug{puts "impacts:#{impacts}"}
    impacts
    # write your code in Ruby 2.2
end

#precalc matrix
#                    0123456
#                    2132241
#                   11166666
#                   203334--
#                   3222----
#                   4555555-
#                   [2,4] 2
#                   [5,5] 4
#                   [0,6] 1

require 'spec_helper'

describe 'Genomic Range Query' do
  specify 'double element' do
    expect(solution('CAGCCTA', [2, 5, 0], [4, 5, 6])).to eq([2, 4, 1])
  end

end
