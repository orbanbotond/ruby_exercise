require 'spec_helper'

def count_biggest_graph(graph)
  max = 0

  graph.each_key do |k|
    count = 1
    accessible = graph[k]
    checked = [k]
    while accessible.size > 0
      current = accessible.shift
      checked << current
      accessible.concat( graph[current]).uniq! if graph.has_key? current
    end
    max = checked.uniq.size if checked.uniq.size > max
  end

  max
end

def solution(a, m)

  divisable = {}

  a.map!.with_index{|x, idx|[idx, x]}

  a.combination(2).to_a.each do |x,y|
    if (x.last - y.last) % m == 0
      divisable[x.first] = divisable.fetch(x.first, []) << y.first
    end
  end
  # puts "divisable:#{divisable}"

  count_biggest_graph(divisable)
end

describe 'M aligned subset' do

  specify 'unit 1_1' do
    a = [-3, -2, 1, 0, 8, 7, 1]
    expect(solution(a, 3)).to eq(4)
  end


end