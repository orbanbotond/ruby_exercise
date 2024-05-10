module Attribute
  module Controls
    module Checked
      Error = Class.new(RuntimeError)

      def self.example
        example = Example.new
        example.some_attr = value
        example
      end

      def self.value
        'some value'
      end

      class Example
        Attribute::Define.(self, :some_attr, :accessor, check: -> (val) { raise Error unless val == Checked.value })
      end
    end
  end
end
