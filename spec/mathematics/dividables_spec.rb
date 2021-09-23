require 'spec_helper'

describe 'Dividables' do
  describe 'by 3' do
    context 'when the sum of their digits are dividable by 3' do
      specify 'the number is dividable by 3' do
        dividables = (1000..2000).to_a.select{|number|number.to_s.chars.map(&:to_i).reduce(0){|accumulator, digit| digit+accumulator}%3==0}
        dividables.each do |number|
          expect(number%3).to eq(0)
        end
      end
    end
  end
end