require "spec_helper"
require "active_attr/typecasting/boolean_typecaster"
require "bigdecimal"

module ActiveAttr
  module Typecasting
    describe BooleanTypecaster do
      subject(:typecaster) { described_class.new }

      describe "#call" do
        it "returns true for true" do
          typecaster.call(true).should equal true
        end

        it "returns false for false" do
          typecaster.call(false).should equal false
        end

        it "casts nil to nil" do
          typecaster.call(nil).should equal nil
        end

        it "casts an Object to true" do
          typecaster.call(Object.new).should equal true
        end

        context "when the value is a String" do
          it "casts an empty String to false" do
            typecaster.call("").should equal nil
          end

          it "casts a non-empty String to true" do
            typecaster.call("abc").should equal true
          end

          it "casts a non-empty String starting with number 0 to true" do
            typecaster.call("0c2").should equal true
          end

          it "casts a non-empty String starting with number > 0 to true" do
            typecaster.call("1c2").should equal true
          end

          {
            "t" => true,
            "f" => false,
            "T" => true,
            "F" => false,
            # http://yaml.org/type/bool.html
            "y" => true,
            "Y" => true,
            "yes" => true,
            "Yes" => true,
            "YES" => true,
            "n" => false,
            "N" => false,
            "no" => false,
            "No" => false,
            "NO" => false,
            "true" => true,
            "True" => true,
            "TRUE" => true,
            "false" => false,
            "False" => false,
            "FALSE" => false,
            "on" => true,
            "On" => true,
            "ON" => true,
            "off" => false,
            "Off" => false,
            "OFF" => false,
          }.each_pair do |value, result|
            it "casts #{value.inspect} to #{result.inspect}" do
              typecaster.call(value).should equal result
            end
          end
        end

        context "when the value is Numeric" do
          it "casts 0 to false" do
            typecaster.call(0).should equal false
          end

          it "casts 1 to true" do
            typecaster.call(1).should equal true
          end

          it "casts 0.0 to false" do
            typecaster.call(0.0).should equal false
          end

          it "casts 0.1 to true" do
            typecaster.call(0.1).should equal true
          end

          it "casts a zero BigDecimal to false" do
            typecaster.call(BigDecimal("0.0")).should equal false
          end

          it "casts a non-zero BigDecimal to true" do
            typecaster.call(BigDecimal("0.1")).should equal true
          end

          it "casts -1 to true" do
            typecaster.call(-1).should equal true
          end

          it "casts -0.0 to false" do
            typecaster.call(-0.0).should equal false
          end

          it "casts -0.1 to true" do
            typecaster.call(-0.1).should equal true
          end

          it "casts a negative zero BigDecimal to false" do
            typecaster.call(BigDecimal("-0.0")).should equal false
          end

          it "casts a negative BigDecimal to true" do
            typecaster.call(BigDecimal("-0.1")).should equal true
          end
        end

        context "when the value is the String version of a Numeric" do
          it "casts '0' to false" do
            typecaster.call("0").should equal false
          end

          it "casts '0\\nx' to true" do
            typecaster.call("0\nx").should equal true
          end

          it "casts '1' to true" do
            typecaster.call("1").should equal true
          end

          it "casts '0.0' to false" do
            typecaster.call("0.0").should equal false
          end

          it "casts '.0' to false" do
            typecaster.call(".0").should equal false
          end

          it "casts '0.' to false" do
            typecaster.call("0.").should equal false
          end

          it "casts '0.1' to true" do
            typecaster.call("0.1").should equal true
          end

          it "casts '-1' to true" do
            typecaster.call("-1").should equal true
          end

          it "casts '+1' to true" do
            typecaster.call("+1").should equal true
          end

          it "casts '-0.0' to false" do
            typecaster.call("-0.0").should equal false
          end

          it "casts '+0.0' to false" do
            typecaster.call("+0.0").should equal false
          end

          it "casts '-0.1' to true" do
            typecaster.call("-0.1").should equal true
          end

          it "casts '+0.1' to true" do
            typecaster.call("+0.1").should equal true
          end
        end
      end
    end
  end
end
