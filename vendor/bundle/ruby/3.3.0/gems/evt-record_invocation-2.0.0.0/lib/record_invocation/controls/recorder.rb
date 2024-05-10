module RecordInvocation
  module Controls
    module Recorder
      def self.example
        Example.new
      end

      class Example
        include ::RecordInvocation

        def some_method
          record_invocation(binding)
        end
      end

      module RecordMacro
        def self.example
          Example.new
        end

        class Example
          include ::RecordInvocation

          record def some_recorded_method(
            some_parameter,
            some_optional_parameter=nil,
            *some_multiple_assignment_parameter,
            some_keyword_parameter:,
            some_optional_keyword_parameter: nil,
            **some_multiple_assignment_keyword_parameter,
            &some_block
          )
            :some_result
          end
        end

        module IgnoredParameters
          def self.example
            Example.new
          end

          class Example
            include ::RecordInvocation

            record def some_recorded_method(
              *,
              **,
              &
            )
            end
          end
        end
      end
    end
  end
end
