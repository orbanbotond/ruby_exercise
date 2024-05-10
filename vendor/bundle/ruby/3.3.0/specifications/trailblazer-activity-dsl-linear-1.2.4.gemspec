# -*- encoding: utf-8 -*-
# stub: trailblazer-activity-dsl-linear 1.2.4 ruby lib

Gem::Specification.new do |s|
  s.name = "trailblazer-activity-dsl-linear".freeze
  s.version = "1.2.4".freeze

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Nick Sutterer".freeze]
  s.date = "2023-07-03"
  s.email = ["apotonick@gmail.com".freeze]
  s.homepage = "https://trailblazer.to/2.1/docs/activity".freeze
  s.licenses = ["LGPL-3.0".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.5.0".freeze)
  s.rubygems_version = "3.5.3".freeze
  s.summary = "The #step DSL for Trailblazer activities.".freeze

  s.installed_by_version = "3.5.3".freeze if s.respond_to? :installed_by_version

  s.specification_version = 4

  s.add_runtime_dependency(%q<trailblazer-activity>.freeze, [">= 0.16.0".freeze, "< 0.17.0".freeze])
  s.add_runtime_dependency(%q<trailblazer-declarative>.freeze, [">= 0.0.1".freeze, "< 0.1.0".freeze])
  s.add_development_dependency(%q<bundler>.freeze, [">= 0".freeze])
  s.add_development_dependency(%q<minitest>.freeze, [">= 5.15.0".freeze, "< 5.16.0".freeze])
  s.add_development_dependency(%q<rake>.freeze, [">= 0".freeze])
  s.add_development_dependency(%q<trailblazer-core-utils>.freeze, ["= 0.0.2".freeze])
end
