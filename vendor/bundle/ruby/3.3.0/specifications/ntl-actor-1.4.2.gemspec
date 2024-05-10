# -*- encoding: utf-8 -*-
# stub: ntl-actor 1.4.2 ruby lib src

Gem::Specification.new do |s|
  s.name = "ntl-actor".freeze
  s.version = "1.4.2".freeze

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze, "src".freeze]
  s.authors = ["Nathan Ladd".freeze]
  s.date = "2024-04-25"
  s.description = "Implementation of actor pattern for Ruby".freeze
  s.email = "nathanladd+github@gmail.com".freeze
  s.homepage = "https://github.com/ntl/actor".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.5.3".freeze
  s.summary = "Implementation of actor pattern for Ruby".freeze

  s.installed_by_version = "3.5.3".freeze if s.respond_to? :installed_by_version

  s.specification_version = 4

  s.add_runtime_dependency(%q<observer>.freeze, [">= 0".freeze])
  s.add_development_dependency(%q<test_bench>.freeze, [">= 0".freeze])
end
