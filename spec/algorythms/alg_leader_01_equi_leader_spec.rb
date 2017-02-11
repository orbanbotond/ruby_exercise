require 'spec_helper'

def solution(a)
    candidate = nil
    candidate_idx = 0
    candidate_count = 0
    a.each_with_index do |x, idx|
        if candidate_count == 0
            candidate = x
            candidate_idx = idx
            candidate_count += 1
        elsif x == candidate
            candidate_count += 1
        else
            candidate_count -= 1
        end
    end

    leader_count = a.count{|x|x == candidate}
    if leader_count > a.size/2
        leader = candidate
    else
        return 0
    end

    leader_count_so_far = 0
    equi_leader_counts = 0
    a.each_with_index do |x, idx|
        leader_count_so_far += 1 if x == leader
        equi_leader_counts +=1 if leader_count_so_far > (idx + 1) / 2 &&
           (leader_count - leader_count_so_far) > ((a.size - idx -1) / 2)
    end
    equi_leader_counts
end

require 'spec_helper'

describe 'Equi Leader' do

  specify 'solu 1' do
    #0 and #2 are equi leaders
    expect(solution([4,3,4,4,4,2])).to eq(2)
  end

end
