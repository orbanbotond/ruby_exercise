# -*- encoding: utf-8 -*-
# stub: granite 0.17.0 ruby lib

Gem::Specification.new do |s|
  s.name = "granite".freeze
  s.version = "0.17.0".freeze

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Toptal Engineering".freeze]
  s.date = "2023-10-09"
  s.homepage = "https://github.com/toptal/granite".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.5".freeze)
  s.rubygems_version = "3.5.3".freeze
  s.summary = "Another business actions architecture for Rails apps".freeze

  s.installed_by_version = "3.5.3".freeze if s.respond_to? :installed_by_version

  s.specification_version = 4

  s.add_runtime_dependency(%q<actionpack>.freeze, [">= 6.0".freeze, "< 7.2".freeze])
  s.add_runtime_dependency(%q<granite-form>.freeze, [">= 0.3.0".freeze])
  s.add_runtime_dependency(%q<activesupport>.freeze, [">= 6.0".freeze, "< 7.2".freeze])
  s.add_runtime_dependency(%q<memoist>.freeze, ["~> 0.16".freeze])
  s.add_runtime_dependency(%q<ruby2_keywords>.freeze, ["~> 0.0.5".freeze])
  s.add_development_dependency(%q<activerecord>.freeze, [">= 0".freeze])
  s.add_development_dependency(%q<appraisal>.freeze, [">= 0".freeze])
  s.add_development_dependency(%q<bump>.freeze, [">= 0".freeze])
  s.add_development_dependency(%q<capybara>.freeze, ["~> 2.18".freeze])
  s.add_development_dependency(%q<fuubar>.freeze, ["~> 2.0".freeze])
  s.add_development_dependency(%q<pg>.freeze, ["< 2".freeze])
  s.add_development_dependency(%q<pry-byebug>.freeze, [">= 0".freeze])
  s.add_development_dependency(%q<rspec>.freeze, ["~> 3.12".freeze])
  s.add_development_dependency(%q<rspec-activemodel-mocks>.freeze, ["~> 1.0".freeze])
  s.add_development_dependency(%q<rspec-collection_matchers>.freeze, ["~> 1.1".freeze])
  s.add_development_dependency(%q<rspec-its>.freeze, ["~> 1.2".freeze])
  s.add_development_dependency(%q<rspec-rails>.freeze, ["~> 5.0".freeze])
  s.add_development_dependency(%q<rspec_junit_formatter>.freeze, ["~> 0.2".freeze])
  s.add_development_dependency(%q<rubocop>.freeze, ["~> 1.0".freeze])
  s.add_development_dependency(%q<rubocop-rails>.freeze, ["~> 2.13".freeze])
  s.add_development_dependency(%q<rubocop-rspec>.freeze, ["~> 2.8".freeze])
  s.add_development_dependency(%q<simplecov>.freeze, ["~> 0.15".freeze])
end
