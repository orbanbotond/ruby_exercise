module Attribute
  module Controls
    module Writer
      def self.example
        Example.new
      end

      class Example
        Attribute::Define.(self, :some_attr, :writer)
      end
    end
  end
end
