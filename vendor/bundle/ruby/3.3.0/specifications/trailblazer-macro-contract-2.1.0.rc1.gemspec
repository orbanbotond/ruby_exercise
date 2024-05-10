# -*- encoding: utf-8 -*-
# stub: trailblazer-macro-contract 2.1.0.rc1 ruby lib

Gem::Specification.new do |s|
  s.name = "trailblazer-macro-contract".freeze
  s.version = "2.1.0.rc1".freeze

  s.required_rubygems_version = Gem::Requirement.new("> 1.3.1".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Nick Sutterer".freeze]
  s.date = "2018-06-18"
  s.description = "Trailblazer operation form object specific macros".freeze
  s.email = ["apotonick@gmail.com".freeze]
  s.homepage = "http://trailblazer.to".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.0.0".freeze)
  s.rubygems_version = "3.5.3".freeze
  s.summary = "Macros for form-objects: Build, Validate, Persist".freeze

  s.installed_by_version = "3.5.3".freeze if s.respond_to? :installed_by_version

  s.specification_version = 4

  s.add_runtime_dependency(%q<reform>.freeze, [">= 2.2.0".freeze, "< 3.0.0".freeze])
  s.add_development_dependency(%q<bundler>.freeze, [">= 0".freeze])
  s.add_development_dependency(%q<trailblazer-macro>.freeze, [">= 2.1.0.rc1".freeze, "< 2.2.0".freeze])
  s.add_development_dependency(%q<reform-rails>.freeze, [">= 0".freeze])
  s.add_development_dependency(%q<dry-validation>.freeze, [">= 0".freeze])
  s.add_development_dependency(%q<minitest>.freeze, [">= 0".freeze])
  s.add_development_dependency(%q<rake>.freeze, [">= 0".freeze])
end
