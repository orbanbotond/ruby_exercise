module Attribute
  module Define
    extend self

    def call(target_class, attr_name, visibility=nil, check: nil, &initialize_value)
      visibility ||= :reader

      if [:reader, :accessor].include? visibility
        define_reader(target_class, attr_name, visibility, check, &initialize_value)
      end

      if [:writer, :accessor].include? visibility
        define_writer(target_class, attr_name, visibility, check, &initialize_value)
      end

      attr_name
    end

    def define_reader(target_class, attr_name, visibility, check, &initialize_value)
      attr_name = :"#{attr_name}" unless attr_name.is_a? Symbol
      var_name = "@#{attr_name}"
      target_class.send :define_method, attr_name do

        defined = instance_variable_defined?(var_name)

        val = nil
        if defined
          val = instance_variable_get(var_name)
        else
          unless initialize_value.nil?
            val = initialize_value.()
          end
          instance_variable_set var_name, val
        end

        if check
          check.(val)
        end

        val
      end
    end

    def define_writer(target_class, attr_name, visibility, check, &initialize_value)
      attr_name = :"#{attr_name}" unless attr_name.is_a? Symbol
      writer_name = :"#{attr_name}="
      var_name = "@#{attr_name}"
      target_class.send :define_method, writer_name do |val|
        if check
          check.(val)
        end

        instance_variable_set var_name, val
      end
    end
  end
end
