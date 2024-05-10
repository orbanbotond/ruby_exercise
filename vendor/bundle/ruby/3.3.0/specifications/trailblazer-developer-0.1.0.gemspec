# -*- encoding: utf-8 -*-
# stub: trailblazer-developer 0.1.0 ruby lib

Gem::Specification.new do |s|
  s.name = "trailblazer-developer".freeze
  s.version = "0.1.0".freeze

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Nick Sutterer".freeze]
  s.date = "2023-06-14"
  s.description = "Developer tools for Trailblazer: debugger, activity visualizer and tracing.".freeze
  s.email = ["apotonick@gmail.com".freeze]
  s.homepage = "http://trailblazer.to/2.1/docs/trailblazer.html#trailblazer-developer".freeze
  s.licenses = ["LGPL-3.0".freeze]
  s.rubygems_version = "3.5.3".freeze
  s.summary = "Developer tools for Trailblazer.".freeze

  s.installed_by_version = "3.5.3".freeze if s.respond_to? :installed_by_version

  s.specification_version = 4

  s.add_development_dependency(%q<bundler>.freeze, [">= 0".freeze])
  s.add_development_dependency(%q<minitest>.freeze, [">= 0".freeze])
  s.add_development_dependency(%q<minitest-line>.freeze, [">= 0".freeze])
  s.add_development_dependency(%q<rake>.freeze, [">= 0".freeze])
  s.add_development_dependency(%q<trailblazer-operation>.freeze, [">= 0.10.0".freeze])
  s.add_runtime_dependency(%q<trailblazer-activity-dsl-linear>.freeze, [">= 1.2.0".freeze, "< 1.3.0".freeze])
  s.add_runtime_dependency(%q<hirb>.freeze, [">= 0".freeze])
end
