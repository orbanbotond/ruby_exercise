module Reflect
  module Controls
    module Ancestor
      def self.example
        Example.new
      end

      class Example
        module SomeConstant
        end

        class Descendant < Example
        end
      end
    end
  end
end
