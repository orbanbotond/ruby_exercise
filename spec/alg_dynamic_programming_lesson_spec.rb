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

require 'spec_helper'

describe 'smallest number of coins' do

  specify 'dynamic algorythm test' do
    expect(solution([1, 3, 4], 6)).to eq(2)
  end

end
  












