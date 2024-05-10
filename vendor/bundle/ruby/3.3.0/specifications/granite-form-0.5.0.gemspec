# -*- encoding: utf-8 -*-
# stub: granite-form 0.5.0 ruby lib

Gem::Specification.new do |s|
  s.name = "granite-form".freeze
  s.version = "0.5.0".freeze

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Toptal Engineering".freeze]
  s.date = "2023-10-09"
  s.description = "Making object from any hash or hash array".freeze
  s.homepage = "https://github.com/toptal/granite-form".freeze
  s.required_ruby_version = Gem::Requirement.new(">= 2.4.0".freeze)
  s.rubygems_version = "3.5.3".freeze
  s.summary = "Working with hashes in AR style".freeze

  s.installed_by_version = "3.5.3".freeze if s.respond_to? :installed_by_version

  s.specification_version = 4

  s.add_development_dependency(%q<actionpack>.freeze, [">= 6.0".freeze])
  s.add_development_dependency(%q<activerecord>.freeze, [">= 6.0".freeze])
  s.add_development_dependency(%q<appraisal>.freeze, [">= 0".freeze])
  s.add_development_dependency(%q<bump>.freeze, [">= 0".freeze])
  s.add_development_dependency(%q<database_cleaner>.freeze, [">= 0".freeze])
  s.add_development_dependency(%q<pg>.freeze, [">= 0".freeze])
  s.add_development_dependency(%q<rake>.freeze, [">= 0".freeze])
  s.add_development_dependency(%q<rspec>.freeze, ["~> 3.7.0".freeze])
  s.add_development_dependency(%q<rspec-its>.freeze, [">= 0".freeze])
  s.add_development_dependency(%q<rubocop>.freeze, ["= 0.52.1".freeze])
  s.add_development_dependency(%q<uuidtools>.freeze, [">= 0".freeze])
  s.add_runtime_dependency(%q<activemodel>.freeze, [">= 6.0".freeze])
  s.add_runtime_dependency(%q<activesupport>.freeze, [">= 6.0".freeze])
  s.add_runtime_dependency(%q<tzinfo>.freeze, [">= 0".freeze])
end
