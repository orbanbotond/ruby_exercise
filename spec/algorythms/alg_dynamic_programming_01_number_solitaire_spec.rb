require 'spec_helper'

describe 'Number Solitaire' do
  # you can use puts for debugging purposes, e.g.
  # puts "this is a debug message"

  def do_debug
    # debugging = true
    debugging = false
    puts yield if debugging
  end

  #
  # Detected time complexity:
  # O(N*log(N))
  def solution(a)
    puts "a:#{a}"
    a.each_with_index do |elem, idx|
      next if idx ==0
      bidx = [idx - 6, 0].max
      last_6_max = a[bidx..(idx-1)].max
      a[idx] += last_6_max
      # puts "a:#{a}"
    end
    a[-1]
  end

  def solution(a)
    d = Array.new a.size, -10000000000000
    d[0] = a[0]
    a.each_with_index do |elem, idx|
      1.upto(6) do |inner|
        next if idx -inner < 0
        d[idx] = [d[idx], d[idx - inner] + a[idx]].max
      end

    end
    d[-1]
  end

  specify 'extreme small ones' do
    expect(solution([1, -2, 0, 9, -1, -2])).to eq(8)
  end

  specify 'ensures tha last 6 max + actual' do
    expect(solution([1, -2, 9, 8, -3, -3, -3, -3, -2, -1])).to eq(17)
  end

end
