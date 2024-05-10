module Reflect
  class Reflection
    attr_reader :subject
    attr_reader :target
    alias :constant :target
    attr_reader :strict

    def subject_constant
      @subject_constant ||= Reflect.constant(subject)
    end

    def initialize(subject, target, strict)
      @subject = subject
      @target = target
      @strict = strict
    end

    def self.build(subject, constant_name, strict: nil, ancestors: nil)
      strict = Default.strict if strict.nil?
      ancestors = Default.ancestors if ancestors.nil?

      subject_constant = Reflect.constant(subject)

      target = Reflect.get_constant(subject_constant, constant_name, strict: strict, ancestors: ancestors)
      return nil if target.nil?

      new(subject, target, strict)
    end

    def call(method_name, arg=nil)
      unless target.respond_to?(method_name)
        target_name = Reflect.constant(target).name
        raise Reflect::Error, "#{target_name} does not define method #{method_name}"
      end

      arg ||= subject

      target.send(method_name, arg)
    end

    def target_accessor?(name, subject=nil)
      subject ||= constant
      subject.respond_to?(name)
    end

    def get(accessor_name, strict: nil, coerce_constant: nil)
      strict = self.strict if strict.nil?
      coerce_constant = true if coerce_constant.nil?

      target = get_target(accessor_name, strict: strict)
      return nil if target.nil?

      if coerce_constant
        target = Reflect.constant(target)
      end

      self.class.new(subject, target, strict)
    end

    def get_target(accessor_name, strict: nil)
      strict = self.strict if strict.nil?

      if !target_accessor?(accessor_name)
        if strict
          target_name = Reflect.constant(target).name
          raise Reflect::Error, "#{target_name} does not have accessor #{accessor_name}"
        else
          return nil
        end
      end

      target.send(accessor_name)
    end

    module Default
      def self.strict
        true
      end

      def self.ancestors
        false
      end
    end
  end
end
