# -*- encoding: utf-8 -*-
# stub: trailblazer-macro 2.1.15 ruby lib

Gem::Specification.new do |s|
  s.name = "trailblazer-macro".freeze
  s.version = "2.1.15".freeze

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Nick Sutterer".freeze]
  s.date = "2023-06-14"
  s.description = "Macros for Trailblazer's operation".freeze
  s.email = ["apotonick@gmail.com".freeze]
  s.homepage = "http://trailblazer.to".freeze
  s.licenses = ["LGPL-3.0".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.5.0".freeze)
  s.rubygems_version = "3.5.3".freeze
  s.summary = "Macros for Trailblazer's operation: Policy, Wrap, Rescue and more.".freeze

  s.installed_by_version = "3.5.3".freeze if s.respond_to? :installed_by_version

  s.specification_version = 4

  s.add_development_dependency(%q<minitest>.freeze, [">= 0".freeze])
  s.add_development_dependency(%q<rake>.freeze, [">= 0".freeze])
  s.add_development_dependency(%q<trailblazer-developer>.freeze, [">= 0.1.0".freeze, "< 0.2.0".freeze])
  s.add_runtime_dependency(%q<trailblazer-operation>.freeze, [">= 0.10.1".freeze])
  s.add_runtime_dependency(%q<trailblazer-activity-dsl-linear>.freeze, [">= 1.2.0".freeze, "< 1.3.0".freeze])
end
