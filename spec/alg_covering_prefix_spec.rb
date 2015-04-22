def solution(a)
  h = {}
  a.each_with_index do |x, idx|
    h[x] = idx if h.fetch(x){10000000000000} > idx
  end
  h.each_values.max
end
