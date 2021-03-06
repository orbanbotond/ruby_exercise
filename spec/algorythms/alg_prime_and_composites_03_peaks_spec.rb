require 'spec_helper'

describe 'count the block wrapping the peaks' do

  def solution(h)
    # puts "#{h}"
    a = h.size
    return 0 if a < 3

    peaks = []
    h.each_cons(3).with_index do |pair, idx|
      x = pair[0]
      y = pair[1]
      z = pair[2]
      peaks << (idx + 1) if y > x && y > z
    end
    return 0 if peaks.size == 0
    # puts "peaks:#{peaks}"

    last_factor = 1
    factors = []
    while last_factor*last_factor < a do
      if a % last_factor == 0
        factors << [last_factor, a/last_factor]
      end
      last_factor += 1
    end

    if last_factor*last_factor == a
      factors << last_factor
    end

    factors.flatten!.sort!  

    # puts "size:#{a} factors:#{factors}"

    block_number = 0

    hh = h.to_enum.with_index.map { |e, i| i }

    factors.reverse_each do |block_nr|
      block_size = a / block_nr
      success = true
      1.upto(block_nr) do |slice_nr|
        bl_start = (slice_nr-1) * block_size
        bl_end = slice_nr * block_size - 1

        # puts "block start:#{bl_start} block_end:#{bl_end}"
        if peaks.none?{|p| bl_start <= p  && p <= bl_end}
          # puts "#{bl_start}..#{bl_end} doesn't contain peaks"
          success = false
          break
        end
      end
      return block_nr if success
      # puts "last_block_nr: #{last_block_nr}"
    end

    return 0
  end

  def solution_faster(a)
    peaks = []
    a.each_cons(3).with_index do |xx, idx|
      x,y,z = xx
      peaks << (idx +1) if y > x && y > z
    end

    n = a.size
    1.upto(n) do |block_size|
      next unless n % block_size == 0
      peak_matching = 0
      ok = true
      peaks.each do |peak_idx|
        if peak_idx / block_size > peak_matching
          ok = false
          break
        end
        peak_matching += 1 if (peak_idx / block_size ==  peak_matching)
      end

      ok = false if (peak_matching!= n/block_size)
      return n/block_size if ok
    end

    return 0
  end

  specify 'simple wo peaks' do
    expect(solution([5])).to eq(0)
  end

  specify 'anti bin search' do
    expect(solution([0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0])).to eq(7)
  end

  specify 'simple' do
    expect(solution([1,  2,  3,  4,  3,  4,  1,  2,  3,  4, 6 , 2])).to eq(3)
  end


  specify 'simple 1' do
    expect(solution([5, 6, 5, 6, 1, 1, 1, 1, 6, 5, 6, 5])).to eq(4)
  end

  specify 'simple 2' do
    expect(solution([1, 6, 1, 1, 1, 1, 1, 6, 1, 1, 1, 1, 1, 1, 1, 1, 6, 1, 1, 1, 1, 1, 6, 1])).to eq(4)
  end

end
