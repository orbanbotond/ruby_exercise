# -*- encoding: utf-8 -*-
# stub: ruport 1.8.0 ruby lib

Gem::Specification.new do |s|
  s.name = "ruport".freeze
  s.version = "1.8.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.metadata = { "changelog_uri" => "https://github.com/ruport/ruport/blob/master/CHANGELOG.md", "source_code_uri" => "https://github.com/ruport/ruport" } if s.respond_to? :metadata=
  s.require_paths = ["lib".freeze]
  s.authors = ["Gregory Brown".freeze, "Mike Milner".freeze, "Andrew France".freeze]
  s.date = "2022-09-19"
  s.description = "Ruby Reports is a software library that aims to make the task of reporting\n      less tedious and painful. It provides tools for data acquisition,\n      database interaction, formatting, and parsing/munging.\n".freeze
  s.email = "gregory.t.brown@gmail.com".freeze
  s.homepage = "http://github.com/ruport/ruport".freeze
  s.rubygems_version = "3.4.10".freeze
  s.summary = "A generalized Ruby report generation and templating engine.".freeze

  s.installed_by_version = "3.4.10" if s.respond_to? :installed_by_version

  s.specification_version = 4

  s.add_runtime_dependency(%q<prawn>.freeze, ["~> 2.4.0"])
  s.add_runtime_dependency(%q<prawn-table>.freeze, ["~> 0.2.0"])
  s.add_development_dependency(%q<rake>.freeze, [">= 0"])
end
