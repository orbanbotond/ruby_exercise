require 'spec_helper'

describe 'count triangles' do

  # you can use puts for debugging purposes, e.g.
  # puts "this is a debug message"

  def solution_n3(a)
    if a.size < 3
      return 0
    else
      a.sort!
      count = 0
      size = a.size
      size -= 1

      0.upto(size) do |i|
        (i+1).upto(size) do |k1|
          (k1+1).upto(size) do |k2|
            count +=1 if a[i] + a[k1] > a[k2]
          end
        end
      end

      return count
    end
    # write your code in Ruby 2.2
  end

  def solution(a)
    if a.size < 3
      return 0
    else
      a.sort!
      result = 0
      size = a.size
      size -= 1

      0.upto(size) do |x|
        z = 0
        (x+1).upto(size) do |y|
          while(z <= size && a[x] + a[y] > a[z]) do
            z += 1
          end
          result += z - y - 1
        end
      end

      return result
    end
    # write your code in Ruby 2.2
  end

  specify 'normal case' do
    expect(solution([10, 2, 5, 1, 8, 12] )).to eq(4)
  end

  specify 'negative case' do
    expect(solution([1, 2, 3] )).to eq(0)
  end

end
