require 'spec_helper'

describe 'Nailing planks' do

  def do_debug string
    puts string
  end

  #This algorythm is not ok, because it depends on the input.
  #If I sort the nail sequence then the algorythm fails
  def findFirstNail(plankBegin, plankEnd, nails)
      do_debug "b:#{plankBegin} e:#{plankEnd} nails:#{nails}"
      result = -1     # The index of nail in the original array
      resultPos = -1  # The index of nail in the sorted array
   
      nailLower = 0
      nailUpper = nails.size - 1
      nailMid = 0
   
      while nailLower <= nailUpper do
        nailMid = (nailLower + nailUpper) / 2
        nailPosMid = nails[nailMid][1]
        do_debug "l:#{nailLower} u:#{nailUpper} m:#{nailMid} npm:#{nailPosMid}"
        if nailPosMid < plankBegin
          nailLower = nailMid + 1
          do_debug "rising lower bound nailLower:#{nailLower}"
        elsif nailPosMid > plankEnd
          nailUpper = nailMid - 1
          do_debug "lowering upper bound nailUpper:#{nailUpper}"
        else
          nailUpper = nailMid - 1
          result = nails[nailMid][0]
          resultPos = nailMid
          do_debug "adjusting: upper bound nailUpper:#{nailUpper}"
          do_debug "result: #{result}"
          do_debug "resultPos: #{resultPos}"
        end
      end
      [result, resultPos]
  end 

  def walk(resultPos, result, nails, plankEnd, preResult)
    resultPos += 1
    while resultPos < nails.size
        break if nails[resultPos][1] > plankEnd
        result = [result, nails[resultPos][0]].min
        resultPos += 1
        # If we find a position before the preResult. We could
        # terminate our search and return.
        # With a position before the preResult, the result for
        # this round must <= preResult. And globally, the final
        # result is the maximum of ALL the results in each rounds.
        # So the result of this round actually does not affect
        # the final result.
        return preResult if preResult >= result
    end
    return [result, preResult].max
  end

  def solution__(a, b, c)
    do_debug "a:#{a} b:#{b} c:#{c}"

    input = [a,b].transpose
    nails = c.map.with_index{|x, idx| [idx, x]}.sort{|x,y|x.last <=> y.last}
    preResult = -1
    input.each do |x|
      r, p = findFirstNail x.first, x.last, nails
      puts "r: #{r} p:#{p}"
      preResult = walk p, r, nails, x.last, preResult
      return -1 if preResult == -1
    end

    return preResult + 1
  end

  def are_all_nailed?(nails, planks, max_nail_nr)
    nailed_planks = Array.new(planks.size, false)
    0.upto(max_nail_nr - 1) do |nail_idx|
      planks.each_with_index do |plank, idx|
        nailed_planks[idx] = true if plank.first <= nails[nail_idx] && nails[nail_idx] <= plank.last
      end
    end
    # puts "Trying with: max:#{max_nail_nr} all?:#{nailed_planks.all?{|x|x}}"
    nailed_planks.all?{|x|x}
  end

  def solution(a, b, c)
    nails = c
    planks  = [a, b].transpose

    start_nail_count = 1
    end_nail_count = c.size

    min = -1
    while start_nail_count <= end_nail_count do
      middle = (start_nail_count + end_nail_count) / 2
      if are_all_nailed?(nails, planks, middle)
        end_nail_count = middle - 1
        min = middle
      else
        start_nail_count = middle + 1
      end
    end

    min
  end

  specify 'simple' do
    a = [1,4,5,8 ]
    b = [4,5,9,10]
      # [0,1,2,3,4,5,6]
    # c = [1,2,4,5,6,9,3]
    # c = [1,2,5,4,6,9,3]
    c = [4,6,7,10,2]
    # c = [4,6,7,10,2].sort!
    # c = [1,2,5,4,6,9,3].reverse

    # [0,1,6,3,2,4,5]
    # [1,2,3,4,5,6,9]
    expect(solution(a, b, c)).to eq(4)
  end

  specify 'sophisticated' do
    a = [28, 18, 43, 15, 26, 18, 21, 49, 6, 23, 12, 18, 50, 17, 31, 21, 37, 23, 9, 22, 21, 40, 29, 10, 34, 15, 26, 11, 21, 40, 26, 38, 38, 30, 33, 20, 31, 39, 5, 47, 19, 7, 8, 18, 4, 20, 21, 33, 24, 47, 33, 17, 44, 35, 49, 37, 49, 11, 14, 49, 2, 47, 46, 7, 8, 46, 48, 44, 37, 38, 16, 1, 32, 45, 48, 26, 1, 9, 23, 12, 2, 10, 25, 7, 6, 9, 2, 40, 44, 11, 32, 44, 13, 17, 45, 39, 32, 40, 29, 16]
    b = [55, 32, 44, 48, 36, 31, 41, 81, 56, 46, 62, 68, 62, 20, 39, 63, 67, 69, 58, 55, 48, 43, 30, 51, 68, 53, 54, 45, 53, 85, 31, 63, 53, 72, 77, 32, 35, 51, 21, 86, 39, 45, 23, 44, 13, 52, 47, 76, 72, 73, 36, 64, 92, 59, 73, 84, 61, 24, 49, 83, 36, 89, 72, 28, 19, 56, 66, 66, 74, 69, 42, 20, 63, 64, 88, 58, 36, 28, 49, 48, 50, 36, 41, 42, 12, 26, 3, 68, 56, 30, 72, 76, 14, 39, 45, 80, 57, 83, 42, 57]
    c = [55, 35, 85, 29, 52, 35, 42, 98, 11, 45, 23, 35, 100, 33, 61, 42, 74, 45, 18, 44, 41, 80, 57, 20, 68, 30, 52, 22, 42, 79, 52, 76, 76, 59, 65, 40, 62, 78, 10, 94, 37, 14, 16, 35, 7, 40, 42, 66, 47, 94, 66, 33, 88, 70, 97, 74, 97, 21, 28, 98, 3, 93, 92, 14, 16, 92, 96, 87, 73, 76, 31, 1, 63, 89, 95, 52, 1, 18, 45, 24, 3, 20, 50, 13, 12, 17, 4, 79, 87, 21, 64, 88, 25, 34, 89, 77, 63, 80, 58, 32, 69, 79, 6, 33, 30, 89, 29, 68, 44, 38, 50, 90, 66, 39, 16, 35, 48, 65, 100, 33, 95, 92, 45, 23, 24, 93, 18, 65, 66, 17, 4, 64, 6, 55, 98, 47, 32, 11, 31, 33, 12, 71, 61, 72, 11, 26, 93, 1, 37, 82, 23, 23, 64, 26, 34, 40, 30, 66, 74, 77, 99, 8, 26, 99, 80, 77, 23, 13, 28, 90, 76, 37, 66, 74, 29, 11, 82, 71, 81, 75, 37, 66, 37, 91, 13, 70, 35, 91, 81, 18, 2, 24, 97, 77, 71, 21, 22, 45, 54, 62, 6, 85, 25, 72, 32, 30, 88, 22, 51, 88, 83, 72, 25, 63, 48, 31, 78, 68, 90, 43, 15, 28, 74, 71, 65, 40, 58, 7, 10, 81, 12, 63, 30, 18, 79, 89, 32, 16, 47, 12, 97, 3, 51, 17, 1, 100, 69, 71, 77, 79, 61, 67, 32, 11, 73, 74, 74, 65, 9, 65, 9, 88, 1, 27, 54, 87, 66, 14, 73, 21, 34, 37, 80, 21, 33, 29, 25, 22, 39, 18, 26, 12, 59, 70, 24, 45, 61, 98, 97, 12, 95, 81, 23, 20, 51, 29, 32, 41, 55, 55]

    expect(solution(a, b, c)).to eq(61)
  end

end
