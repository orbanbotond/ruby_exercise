# you can use puts for debugging purposes, e.g.
# puts "this is a debug message"

def solution(a)
#    axis_intersections = a.map.with_index{|x, idx| [ idx - x, idx + x ] }
    axis_intersections = []
    intersecting_circles_count = 0
    a.each.with_index do |radius, idx|
        left_intersection = idx - radius
        right_intersection = idx + radius
        center = idx
        axis_intersections.each do |intersection|
            intersecting_circles_count +=1 if  center == intersection.first || center == intersection.last || left_intersection <= intersection.last
            
        end
        axis_intersections << [left_intersection, right_intersection]
    end
    intersecting_circles_count
    # write your code in Ruby 2.2
end

#TODO
# Detected time complexity: O(N**3)
describe 'Detect intersecting circles' do
  #TODO
  #check the performance again

  specify 'normal case' do
    expect(solution([1, 5, 2, 1, 4, 0] )).to eq(11)
  end

end
