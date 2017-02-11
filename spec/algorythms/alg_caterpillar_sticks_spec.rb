
def triangles(a)
  n = a.size
  result = 0
  results = []
  a.each_index do |x|
    z=0
    (x+1).upto(n-1) do |y|
      while (z < n and a[x] + a[y] > a[z]) do
        results << [a[x],a[y],a[z]] if y < z
        z += 1
      end
      result += z - y - 1
    end
  end
  return [result,results]
end

require 'spec_helper'

describe 'Caterpillar base' do

  specify 'normal case' do
    input = [1,2,7,4,1,3,6].sort
    res = triangles(input)
    puts "input:#{input}"
    puts "res:#{res}"
    expect(res.first).to be(5)
  end

end
