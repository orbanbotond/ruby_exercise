require 'spec_helper'

def solution(a)
  # puts "a:#{a}"
  direction = []
  a.each_cons(2) do |x,y|
    delta = y - x
    dir = if delta > 0
            1
          elsif delta < 0
            -1
          else
            0
          end

    direction << dir
  end

  # puts "dirs:#{direction}"

  simplified_directions = []
  last = -2
  direction.each do |x|
    if x != last
      last = x
      simplified_directions << x
    end
  end

  # puts "simplified_directions:#{simplified_directions}"

  count = 0

  simplified_directions.each_cons(2) do |x,y|
    count += 1 if x == 1 && y == -1 ||
                  x == -1 && y == 1
  end
  # puts "count peaks:#{count}"

  simplified_directions.each_cons(3) do |x|
    count += 1 if x[0] == 1 && x[1] == 0 && x[2] == -1 ||
                  x[0] == -1 && x[1] == 0 && x[2] == 1 
  end
  # puts "count high platous and depressions:#{count}"

  if simplified_directions.size >= 2
    #minimum
    count += 1 if simplified_directions[0] == 0 && simplified_directions[1] == 1 ||
                  simplified_directions[0] == 1
    #maximum
    count += 1 if simplified_directions[0] == 0 && simplified_directions[1] == -1 ||
                  simplified_directions[0] == -1

    #minimum
    count += 1 if simplified_directions[-2] == 0 && simplified_directions[-1] == -1 ||
                  simplified_directions[-1] == -1
    #maximum
    count += 1 if simplified_directions[-2] == 0 && simplified_directions[-1] == 1 ||
                  simplified_directions[-1] == 1
  elsif simplified_directions.size == 1
    if simplified_directions[0] == 0
      count += 1
    else
      count +=2
    end
  end

  # puts "count edges:#{count}"

  count
end

describe 'Counting Local Extremes' do

  specify 'normal case' do
    input = [2,2,3,4,3,3,2,2,1,1,2,5]
    expect(solution(input)).to eq(4)
  end

  specify 'unit 1' do
    input = [2,4,3]
    expect(solution(input)).to eq(3)
  end

  specify 'unit 1_2' do
    input = [2,4,4,3]
    expect(solution(input)).to eq(3)
  end

  specify 'unit 2' do
    input = [2,1,3]
    expect(solution(input)).to eq(3)
  end

  specify 'unit 2_2' do
    input = [2,1,1,3]
    expect(solution(input)).to eq(3)
  end

  specify 'unit 3_1' do
    input = [1,1,3]
    expect(solution(input)).to eq(2)
  end

  specify 'unit 3_1' do
    input = [1,1,0]
    expect(solution(input)).to eq(2)
  end

  specify 'unit 4_1' do
    input = [1,0,0]
    expect(solution(input)).to eq(1)
  end

  specify 'unit 4_2' do
    input = [-1,0,0]
    expect(solution(input)).to eq(1)
  end

  specify 'unit 5_1' do
    input = [-1,-1, -1]
    expect(solution(input)).to eq(1)
  end

  specify 'unit 5_1' do
    input = [1,2]
    expect(solution(input)).to eq(2)
  end

  specify 'unit 6_1' do
    input = [2,1]
    expect(solution(input)).to eq(2)
  end

  specify 'unit 7' do
    input = []
    expect(solution(input)).to eq(0)
  end

end