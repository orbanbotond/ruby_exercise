require 'spec_helper'

describe 'count the block wrapping the peaks' do

  def do_debug
    # debugging = true
    debugging = false
    puts(yield) if debugging
  end

  def solution(h)
    do_debug{ "input:#{h}" }

    next_peak = Array.new h.size, nil
    peaks_count = 0
    first_peak = -1

    (h.size-2).downto(1) do |x|
      if h[x] > h[x+1] && h[x] > h[x-1]
        do_debug{"peak detected at:#{x} left:#{h[x-1]} peak:#{h[x]} right:#{h[x+1]}"}
        next_peak[x] = x
        peaks_count += 1
        first_peak = x
      else
        next_peak[x] = next_peak[x+1]
      end
    end
    do_debug{"next_peak:#{next_peak}"}
    do_debug{"peaks_count:#{peaks_count}"}
    do_debug{"first_peak:#{first_peak}"}

    return peaks_count if peaks_count < 2

    max_flags = 1
    max_min_distance = Math.sqrt(h.size).to_i
    (max_min_distance + 1).downto(1) do |min_distance|
      do_debug{"min_distance:#{min_distance}"}
      flags_used = 1
      flags_have = min_distance-1
      pos = first_peak
      do_debug{"flags used:#{flags_used}"}
      do_debug{"flags have:#{flags_have}"}

      while flags_have > 0
        do_debug{"pos:#{pos} (pos + min_distance):#{pos + min_distance} pos_peak: #{next_peak[pos+min_distance]}"}
        break if pos + min_distance >= h.size-1
        pos = next_peak[pos+min_distance]
        break if pos == nil
        flags_used += 1
        flags_have -= 1
        do_debug{"flags_used:#{flags_used} flags_have:#{flags_have}"}
      end
      max_flags = [max_flags, flags_used].max
    end

    return max_flags
  end

  specify 'simple' do
    expect(solution([1,5,3,4,3,4,1,2,3,4,6,2])).to eq(3)
  end

  specify 'no peak' do
    expect(solution([3, 2, 1])).to eq(0)
  end

  specify 'no peak 2' do
    expect(solution([7, 6, 5, 4, 3, 2, 1])).to eq(0)
  end

end
