# -*- encoding: utf-8 -*-
# stub: evt-invocation 2.2.0.0 ruby lib

Gem::Specification.new do |s|
  s.name = "evt-invocation".freeze
  s.version = "2.2.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["The Eventide Project".freeze]
  s.date = "2019-12-10"
  s.description = " ".freeze
  s.email = "opensource@eventide-project.org".freeze
  s.homepage = "https://github.com/eventide-project/invocation".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.4".freeze)
  s.rubygems_version = "3.4.10".freeze
  s.summary = "Extract information about a method's invocation including the method name, parameter names, and parameter values".freeze

  s.installed_by_version = "3.4.10" if s.respond_to? :installed_by_version

  s.specification_version = 4

  s.add_development_dependency(%q<test_bench>.freeze, [">= 0"])
end