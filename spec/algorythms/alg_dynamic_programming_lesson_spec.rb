require 'spec_helper'

describe 'dynamic programming' do

  def solution_frog_jump(jumping_distances, distance)
    n = jumping_distances.size - 1
    dp=[1]+[0]*distance
    1.upto(distance) do |j|
      jumping_distances.each do |distance|
        if distance <= j
          dp[j] += dp[j - distance]
        end
      end
    end

    puts "dp:#{dp}"
    return dp[distance]
  end

  def solution(coins, amount)
    n = coins.size
    dp=[0]+[10000000]*amount
    1.upto(n) do |i|
      puts "i:#{coins[0..(i - 1)]} dp:#{dp}"
      coins[i-1].upto(amount) do |j|
        puts "j:#{j} coins[i-1]:#{coins[i - 1]} idx(j - coins[i - 1]):#{j - coins[i - 1]} dp[idx] + 1:#{dp[j - coins[i - 1]] + 1}  dp[j]:#{dp[j]}"
        dp[j] = [dp[j - coins[i - 1]] + 1, dp[j]].min
      end
    end
    puts "coins:#{coins}"
    puts "dp:#{dp}"
    return dp[amount]
  end

  context "smallest number of coins" do
    specify 'dynamic algorythm test' do
      expect(solution([1, 3, 4], 6)).to eq(2)
    end
  end

  context 'frog jumps' do
    specify 'simple' do
      expect(solution_frog_jump([1, 2],10)).to eq(89)
    end
  end

end
  












