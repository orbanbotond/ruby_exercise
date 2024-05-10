module Attribute
  module Controls
    module Accessor
      def self.example
        Example.new
      end

      class Example
        Attribute::Define.(self, :some_attr, :accessor)
      end

      module InitialValue
        def self.example
          Example.new
        end

        class Example
          Attribute::Define.(self, :some_attr, :accessor) do
            :some_initial_value
          end
        end
      end
    end
  end
end
