# -*- encoding: utf-8 -*-
# stub: evt-record_invocation 2.0.0.0 ruby lib

Gem::Specification.new do |s|
  s.name = "evt-record_invocation".freeze
  s.version = "2.0.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["The Eventide Project".freeze]
  s.date = "2023-07-21"
  s.description = " ".freeze
  s.email = "opensource@eventide-project.org".freeze
  s.homepage = "https://github.com/eventide-project/record-invocation".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.4".freeze)
  s.rubygems_version = "3.4.10".freeze
  s.summary = "Record method invocations, query the invocations, and use predicates to verify a method's invocation".freeze

  s.installed_by_version = "3.4.10" if s.respond_to? :installed_by_version

  s.specification_version = 4

  s.add_runtime_dependency(%q<evt-invocation>.freeze, [">= 0"])
  s.add_development_dependency(%q<test_bench>.freeze, [">= 0"])
end
