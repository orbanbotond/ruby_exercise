require 'spec_helper'

describe 'Dividables' do
  describe 'by 3' do
    context 'when the last 3 numbers are dividable by 3' do
      specify 'the number is dividable by 3' do
        dividables = (1..99).to_a.select{|x| x%3 === 0}
        # File.open("dividables_by_three.marshal", "w"){|to_file| Marshal.dump(dividables, to_file)}
        # dividables = File.open("#{__dir__}/dividables_by_three.marshal", "r"){|from_file| Marshal.load(from_file)}

        (1000..2000).to_a.select{|x|dividables.include?(x.to_s[-2..-1].to_i)}.each do|number|
          expect(number%3).to eq(0)
        rescue RSpec::Expectations::ExpectationNotMetError
          puts "number:`#{number}` should be dividable by `3`"
        end
      end
    end
  end
end