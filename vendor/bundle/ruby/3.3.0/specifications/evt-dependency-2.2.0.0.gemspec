# -*- encoding: utf-8 -*-
# stub: evt-dependency 2.2.0.0 ruby lib

Gem::Specification.new do |s|
  s.name = "evt-dependency".freeze
  s.version = "2.2.0.0".freeze

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["The Eventide Project".freeze]
  s.date = "2023-05-25"
  s.description = " ".freeze
  s.email = "opensource@eventide-project.org".freeze
  s.homepage = "https://github.com/eventide-project/dependency".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.3.3".freeze)
  s.rubygems_version = "3.5.3".freeze
  s.summary = "Declare dependency attributes that have default implementations that are diagnostic substitutes or null objects".freeze

  s.installed_by_version = "3.5.3".freeze if s.respond_to? :installed_by_version

  s.specification_version = 4

  s.add_runtime_dependency(%q<evt-subst_attr>.freeze, [">= 0".freeze])
  s.add_development_dependency(%q<test_bench>.freeze, [">= 0".freeze])
end
