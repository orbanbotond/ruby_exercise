# you can use puts for debugging purposes, e.g.
# puts "this is a debug message"

def solution(a)
    end_points = []
    a.each_with_index do |ai, i|
        end_points << [i - ai, i + ai]
    end
    end_points = end_points.sort_by { |points| points[0]}

    intersecting_pairs = 0
    end_points.each_with_index do |point, index|
        lep, right_ep = point
        pairs = bsearch(end_points, index, end_points.size - 1, right_ep)
        return -1 if 10000000 - pairs + index < intersecting_pairs
        intersecting_pairs += (pairs - index)
    end
    return intersecting_pairs
end

def bsearch(a, l, u, x)
    if l == u
        if x >= a[u][0]
            return u
        else
            return l - 1 
        end
    end
    mid = (l + u)/2

    # Notice that we are searching in higher range
    # even if we have found equality.
    if a[mid][0] <= x
        return bsearch(a, mid+1, u, x)
    else
        return bsearch(a, l, mid, x)
    end
end


def count_intersections(disc_edges, actual_idx)
  actual = disc_edges[actual_idx]
  b = actual_idx + 1
  e = disc_edges.size - 1
  last = 0
  # should find the last which intersects
  while b <= e
    middle = (b + e) / 2
    if disc_edges[middle].first <= actual.last
      last = middle
      b = middle + 1
    else
      e = middle - 1
    end
  end
  intersections = last == 0 ? 0 : last - actual_idx
  intersections
end

def solution_nicer(a)
  disc_edges = a.map.with_index{|x, idx| [idx - x, idx + x]}
  disc_edges.sort!{|x,y| x.first <=> y.first}

  count = 0
  disc_edges.each.with_index do |disc, idx|
    count += count_intersections(disc_edges, idx)
  end

  count > 10000000 ? -1 : count
end


describe 'Detect intersecting circles' do

  specify 'normal case' do
    expect(solution([1, 5, 2, 1, 4, 0])).to eq(11)
  end

end
