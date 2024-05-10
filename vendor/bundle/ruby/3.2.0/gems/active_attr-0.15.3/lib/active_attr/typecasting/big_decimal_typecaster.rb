require "bigdecimal"
require "bigdecimal/util"
require "active_support/core_ext/big_decimal/conversions"
require "active_support/core_ext/object/blank"

module ActiveAttr
  module Typecasting
    # Typecasts an Object to a BigDecimal
    #
    # @example Usage
    #   BigDecimalTypecaster.new.call(1).to_s #=> "0.1E1"
    #
    # @since 0.5.0
    class BigDecimalTypecaster
      # Typecasts an object to a BigDecimal
      #
      # Attempt to convert using #to_d, else it creates a BigDecimal using the
      # String representation of the value.
      #
      # @example Typecast an Integer
      #   typecaster.call(1).to_s #=> "0.1E1"
      #
      # @param [Object, #to_d, #to_s] value The object to typecast
      #
      # @return [BigDecimal, nil] The result of typecasting
      #
      # @since 0.5.0
      def call(value)
        if value.is_a? BigDecimal
          value
        elsif value.is_a? Rational
          value.to_f.to_d
        elsif value.blank?
          nil
        elsif value.respond_to? :to_d
          value.to_d
        else
          BigDecimal(value.to_s)
        end
      rescue ArgumentError
        BigDecimal("0")
      end
    end
  end
end
