module RecordInvocation
  Error = ::Class.new(RuntimeError)

  def self.included(cls)
    cls.class_exec do
      extend Record
    end
  end

  def __records
    @__records ||= []
  end
  alias :records :__records

  def __record(invocation)
    __records << invocation
    records
  end
  alias :record :__record

  def __record_invocation(invocation_or_binding)
    if invocation_or_binding.is_a?(Binding)
      invocation = Invocation.build(invocation_or_binding)
    end

    __record(invocation)
    invocation
  end
  alias :record_invocation :__record_invocation

  def __invocation(method_name, **parameters)
    once = parameters.delete(:once)
    once ||= false

    invocations = __invocations(method_name, **parameters)

    if invocations.empty?
      return nil
    end

    if once && invocations.length > 1
      raise Error, "More than one invocation record matches (Method Name: #{method_name.inspect}, Parameters: #{parameters.inspect})"
    end

    invocations.first
  end
  alias :invocation :__invocation

  def __one_invocation(method_name, **parameters)
    parameters[:once] = true
    __invocation(method_name, **parameters)
  end
  alias :one_invocation :__one_invocation

  def __invocations(method_name=nil, **parameters)
    if method_name.nil? && parameters.empty?
      return __records
    end

    invocations = __records.select { |invocation| invocation.method_name == method_name }

    if parameters.nil?
      return invocations
    end

    if invocations.empty?
      return []
    end

    invocations = invocations.select do |invocation|
      parameters.all? do |match_parameter_name, match_parameter_value|
        invocation_value = invocation.arguments[match_parameter_name]

        invocation_value == match_parameter_value
      end
    end

    invocations
  end
  alias :invocations :__invocations

  def __invoked?(method_name=nil, **parameters)
    if method_name.nil? && parameters.empty?
      return !__records.empty?
    end

    if not parameters.key?(:once)
      parameters[:once] = false
    end

    invocation = __invocation(method_name, **parameters)
    !invocation.nil?
  end
  alias :invoked? :__invoked?

  def __invoked_once?(method_name, **parameters)
    parameters[:once] = true
    __invoked?(method_name, **parameters)
  end
  alias :invoked_once? :__invoked_once?

  module Record
    def record_module
      @record_module ||= prepend_record_module
    end

    def prepend_record_module
      mod = Module.new
      prepend mod
      mod
    end

    def record_macro(method_name, &blk)
      record_module.define_method(method_name) do |*args, **kwargs, &block|
        parameters = method(method_name).super_method.parameters

        positional_arguments = args.dup
        keyword_arguments = kwargs.dup

        arguments = {}

        parameters.each do |type, name|
          case type
          when :req, :opt
            if positional_arguments.any?
              arguments[name] = positional_arguments.shift
            end
          when :rest
            if positional_arguments.any?
              arguments[name] = positional_arguments
            end
          when :key, :keyreq
            if keyword_arguments.key?(name)
              arguments[name] = keyword_arguments.delete(name)
            end
          when :keyrest
            arguments[name] = keyword_arguments
          when :block
            if not block.nil?
              arguments[name] = block
            end
          end
        end

        invocation = Invocation.new(method_name, arguments)
        __record(invocation)

        super(*args, **kwargs, &block)
      end
    end
    alias :record :record_macro
  end
end
