module RecordInvocation
  module Controls
    module Invocation
      def self.example
        parameters = {}
        parameters[:some_parameter] = 1
        parameters[:some_other_parameter] = 11

        invocation = ::Invocation.new(method_name, parameters)

        invocation
      end

      def self.method_name
        :some_method
      end

      module MixedParameters
        def self.example(...)
          instance = Example.new()
          instance.some_method(...)
        end

        class Example
          def some_method(
            some_parameter,
            some_optional_parameter=nil,
            *some_multiple_assignment_parameter,
            some_keyword_parameter:,
            some_optional_keyword_parameter: nil,
            **some_multiple_assignment_keyword_parameter,
            &some_block
          )
            ::Invocation.build(binding)
          end
        end
      end

      module NoParameters
        def self.example
          subject = Example.new
          subject.some_method
        end

        class Example
          def some_method
            ::Invocation.build(binding)
          end
        end
      end
    end
  end
end
