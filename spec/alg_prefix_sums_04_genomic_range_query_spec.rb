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
# 'A' => 1, 'C' => 2, 'G' => 3, 'T' => 4
#                    0123456
#                    CAGCCTA
#                    2132241
#                0 1|1166666
#                1 2|03334--
#                2 3|222----
#                3 4|555555-
#
#                   [2,4] 2 min(2<=_2_<=4, 2<=_3_<=4) = 2
#                   [5,5] 4
#                   [0,6] 1

def solution_nicer(s, p, q)
  size = s.size
  impacts = {'A' => 1, 'C' => 2, 'G' => 3, 'T' => 4}
  s = s.chars.map{|x|impacts[x.upcase]}
  queries = [p, q].transpose

  h = {1=> Array.new(size + 1, -1), 2=>Array.new(size + 1, -1), 3=> Array.new(size + 1, -1), 4=>Array.new(size + 1, -1)}

  s.to_enum.with_index.reverse_each do |x, idx|
    h[1][idx] = h[1][idx + 1]
    h[2][idx] = h[2][idx + 1]
    h[3][idx] = h[3][idx + 1]
    h[4][idx] = h[4][idx + 1]
    h[x][idx] = idx
  end

  queries.map do |query|
    res = []
    res << 1 if query.first <= h[1][query.first] && h[1][query.first] <= query.last
    res << 2 if query.first <= h[2][query.first] && h[2][query.first] <= query.last
    res << 3 if query.first <= h[3][query.first] && h[3][query.first] <= query.last
    res << 4 if query.first <= h[4][query.first] && h[4][query.first] <= query.last
    res.min
  end
#return the minimal impact value for each query

end

require 'spec_helper'

describe 'Genomic Range Query' do
  specify 'double element' do
    expect(solution('CAGCCTA', [2, 5, 0], [4, 5, 6])).to eq([2, 4, 1])
  end

end
