require "spec_helper"
require "active_attr/typecasting/float_typecaster"

module ActiveAttr
  module Typecasting
    describe FloatTypecaster do
      subject(:typecaster) { described_class.new }

      describe "#call" do
        it "returns the original float for a Float" do
          value = 2.0
          typecaster.call(value).should equal value
        end

        it "casts nil to nil" do
          typecaster.call(nil).should eql nil
        end

        it "returns the float version of a String" do
          typecaster.call("2").should eql 2.0
        end

        it "casts an empty String to nil" do
          typecaster.call("").should eql nil
        end

        it "casts an alpha String to a zero Float" do
          typecaster.call("bob").should eql 0.0
        end

        it "returns nil for an object that does not respond to #to_f" do
          typecaster.call(Object.new).should be_nil
        end
      end
    end
  end
end
