require 'spec_helper'

describe 'InfiniteLists' do
  context 'Enumerators' do
    numbers = Enumerator.new do |y|
      a = 1
      loop do
        y.yield a
        a += 1
      end
    end

    context 'without lazy' do
      require 'timeout'
      specify 'will timeout' do
        expect do
          status = Timeout::timeout(2) {
            numbers.select{|x|x % 5 == 0}.first(10)
          }
        end.to raise_error(Timeout::Error)
      end
    end
    context 'with lazy' do
      specify 'will be evaluated' do
        expect(numbers.lazy.select{|x|x % 5 == 0}.first(6)).to eq([5,10,15,20,25,30])
        expect(numbers.lazy.select{|x|x % 5 == 0}.select{|x|x%3 ==0}.first(4)).to eq([15,30,45,60])
      end
    end
  end
end
