# -*- encoding: utf-8 -*-
# stub: trailblazer-developer 0.0.22 ruby lib

Gem::Specification.new do |s|
  s.name = "trailblazer-developer".freeze
  s.version = "0.0.22"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Nick Sutterer".freeze]
  s.date = "2021-07-08"
  s.description = "Developer tools for Trailblazer: debugger, tracing, visual editor integration.".freeze
  s.email = ["apotonick@gmail.com".freeze]
  s.homepage = "http://trailblazer.to".freeze
  s.licenses = ["LGPL-3.0".freeze]
  s.rubygems_version = "3.4.10".freeze
  s.summary = "Developer tools for Trailblazer.".freeze

  s.installed_by_version = "3.4.10" if s.respond_to? :installed_by_version

  s.specification_version = 4

  s.add_development_dependency(%q<bundler>.freeze, [">= 0"])
  s.add_development_dependency(%q<minitest>.freeze, [">= 0"])
  s.add_development_dependency(%q<minitest-line>.freeze, [">= 0"])
  s.add_development_dependency(%q<rake>.freeze, [">= 0"])
  s.add_runtime_dependency(%q<trailblazer-activity>.freeze, [">= 0.12.2", "< 1.0.0"])
  s.add_runtime_dependency(%q<trailblazer-activity-dsl-linear>.freeze, [">= 0.4.1", "< 1.0.0"])
  s.add_runtime_dependency(%q<representable>.freeze, [">= 3.1.1", "< 4.0.0"])
  s.add_runtime_dependency(%q<hirb>.freeze, [">= 0"])
end
