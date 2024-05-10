module SubstAttr
  module Controls
    module Dependency
      class Example
        def self.configure(receiver)
          receiver.constructed_substitute_attr = new
        end

        module Substitute
          def self.build
            :some_substitute
          end
        end

        class Descendant < Example
        end
      end

      module NoSubstituteModule
        class Example
          def some_method
          end
        end
      end

      module MixinSubstitute
        class Example
          module Substitute
            def some_method
            end
          end
        end
      end
    end
  end
end
