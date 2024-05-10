# -*- encoding: utf-8 -*-
# stub: trailblazer-operation 0.10.1 ruby lib

Gem::Specification.new do |s|
  s.name = "trailblazer-operation".freeze
  s.version = "0.10.1".freeze

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Nick Sutterer".freeze]
  s.date = "2023-06-14"
  s.description = "Trailblazer's operation object.".freeze
  s.email = ["apotonick@gmail.com".freeze]
  s.homepage = "https://trailblazer.to/2.1/docs/operation.html".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.5.0".freeze)
  s.rubygems_version = "3.5.3".freeze
  s.summary = "Trailblazer's operation object with railway flow and integrated error handling.".freeze

  s.installed_by_version = "3.5.3".freeze if s.respond_to? :installed_by_version

  s.specification_version = 4

  s.add_runtime_dependency(%q<trailblazer-activity-dsl-linear>.freeze, [">= 1.2.0".freeze, "< 1.4.0".freeze])
  s.add_runtime_dependency(%q<trailblazer-developer>.freeze, [">= 0.1.0".freeze, "< 0.2.0".freeze])
  s.add_development_dependency(%q<bundler>.freeze, [">= 0".freeze])
  s.add_development_dependency(%q<minitest>.freeze, [">= 0".freeze])
  s.add_development_dependency(%q<minitest-line>.freeze, [">= 0".freeze])
  s.add_development_dependency(%q<rake>.freeze, [">= 0".freeze])
end
