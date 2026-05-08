require 'spec_helper'

# TODO transition to test_bench
# Test_bench:
# -----------
# Finished running 10 files, 0 files crashed
# Ran 21 tests in 0.006s (3689 tests/second)
# 21 passed, 0 skipped, 0 failed

# RSpec:
# ------
# Finished in 0.0005 seconds (files took 1.2 seconds to load)
# 1 example, 0 failures

describe 'Configure' do
  context 'a leg with an already existing table' do
    it "creates a leg accessor for the table" do
      table = OpenStruct.new
      table.persons = 4

      class Leg
        include Configure

        configure :leg

        def self.build
          # responsible for configuring its own operational dependencies like wheel.
          new
        end
      end

      leg = Leg.configure table
      expect(table.leg).to eq(leg)
    end
  end
end
