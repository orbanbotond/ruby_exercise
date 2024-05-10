module Attribute
  module Controls
    module Reader
      def self.example
        Example.new
      end

      class Example
        Attribute::Define.(self, :some_attr, :reader)
      end

      module Default
        def self.example
          Example.new
        end

        class Example
          Attribute::Define.(self, :some_attr)
        end
      end
    end
  end
end
