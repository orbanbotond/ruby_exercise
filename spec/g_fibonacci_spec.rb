require 'spec_helper'

describe 'Equilibrum indexes' do

  def generate_fibonacci(n)
    array = Array.new
    array << 0
    array << 1
    2.upto(n).each do |x|
      array << array[-1] + array[-2]
    end
    array
  end

  def solution(a, b, n)
    fibonacci = generate_fibonacci(n)
    (b * fibonacci[n] + a * fibonacci[n - 1]) % 1000000007
  end

  specify 'unit 1' do
    expect(solution(3, 4, 5)).to eq(29)
  end

end
