# -*- encoding: utf-8 -*-
# stub: trailblazer-operation 0.7.5 ruby lib

Gem::Specification.new do |s|
  s.name = "trailblazer-operation".freeze
  s.version = "0.7.5"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Nick Sutterer".freeze]
  s.date = "2021-07-08"
  s.description = "Trailblazer's operation object.".freeze
  s.email = ["apotonick@gmail.com".freeze]
  s.homepage = "http://trailblazer.to".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.1.0".freeze)
  s.rubygems_version = "3.4.10".freeze
  s.summary = "Trailblazer's operation object with railway flow and integrated error handling.".freeze

  s.installed_by_version = "3.4.10" if s.respond_to? :installed_by_version

  s.specification_version = 4

  s.add_runtime_dependency(%q<trailblazer-activity-dsl-linear>.freeze, [">= 0.4.1", "< 1.0.0"])
  s.add_runtime_dependency(%q<trailblazer-activity>.freeze, [">= 0.12.2", "< 1.0.0"])
  s.add_runtime_dependency(%q<trailblazer-developer>.freeze, [">= 0.0.21", "< 1.0.0"])
  s.add_development_dependency(%q<bundler>.freeze, [">= 0"])
  s.add_development_dependency(%q<minitest>.freeze, [">= 0"])
  s.add_development_dependency(%q<rake>.freeze, [">= 0"])
  s.add_development_dependency(%q<rubocop>.freeze, [">= 0"])
end
