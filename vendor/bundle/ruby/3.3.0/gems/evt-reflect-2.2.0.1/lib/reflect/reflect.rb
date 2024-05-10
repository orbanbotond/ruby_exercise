module Reflect
  Error = Class.new(RuntimeError)

  def self.call(subject, constant_name, strict: nil, ancestors: nil)
    Reflection.build(subject, constant_name, strict: strict, ancestors: ancestors)
  end

  def self.constant(subject)
    [Module, Class].include?(subject.class) ? subject : subject.class
  end

  def self.get_constant(subject_constant, constant_name, strict: nil, ancestors: nil)
    strict = Reflection::Default.strict if strict.nil?
    ancestors = Reflection::Default.ancestors if ancestors.nil?

    constant = nil

    if constant?(subject_constant, constant_name, ancestors: ancestors)
      constant = get_constant!(subject_constant, constant_name, ancestors: ancestors)
    end

    if constant.nil? && strict
      raise Reflect::Error, "Namespace #{constant_name} is not defined in #{subject_constant.name}"
    end

    constant
  end

  def self.get_constant!(subject_constant, constant_name, ancestors: nil)
    ancestors = Reflection::Default.ancestors if ancestors.nil?
    subject_constant.const_get(constant_name, ancestors)
  end

  def self.constant?(subject_constant, constant_name, ancestors: nil)
    ancestors = Reflection::Default.ancestors if ancestors.nil?
    subject_constant.const_defined?(constant_name, ancestors)
  end
end
