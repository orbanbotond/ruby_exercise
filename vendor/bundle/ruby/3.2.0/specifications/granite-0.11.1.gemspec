# -*- encoding: utf-8 -*-
# stub: granite 0.11.1 ruby lib

Gem::Specification.new do |s|
  s.name = "granite".freeze
  s.version = "0.11.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Toptal Engineering".freeze]
  s.date = "2021-08-27"
  s.homepage = "https://github.com/toptal/granite".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.4.10".freeze
  s.summary = "Another business actions architecture for Rails apps".freeze

  s.installed_by_version = "3.4.10" if s.respond_to? :installed_by_version

  s.specification_version = 4

  s.add_runtime_dependency(%q<actionpack>.freeze, [">= 5.1", "< 6.1"])
  s.add_runtime_dependency(%q<active_data>.freeze, ["~> 1.1.5"])
  s.add_runtime_dependency(%q<activesupport>.freeze, [">= 5.1", "< 6.1"])
  s.add_runtime_dependency(%q<memoist>.freeze, ["~> 0.16"])
  s.add_development_dependency(%q<activerecord>.freeze, [">= 5.0", "< 6.1"])
  s.add_development_dependency(%q<capybara>.freeze, ["~> 2.18"])
  s.add_development_dependency(%q<fuubar>.freeze, ["~> 2.0"])
  s.add_development_dependency(%q<pg>.freeze, ["< 2"])
  s.add_development_dependency(%q<pry-byebug>.freeze, [">= 0"])
  s.add_development_dependency(%q<rspec>.freeze, ["~> 3.6"])
  s.add_development_dependency(%q<rspec-activemodel-mocks>.freeze, ["~> 1.0"])
  s.add_development_dependency(%q<rspec-collection_matchers>.freeze, ["~> 1.1"])
  s.add_development_dependency(%q<rspec-its>.freeze, ["~> 1.2"])
  s.add_development_dependency(%q<rspec-rails>.freeze, ["~> 3.6"])
  s.add_development_dependency(%q<rspec_junit_formatter>.freeze, ["~> 0.2"])
  s.add_development_dependency(%q<rubocop>.freeze, ["~> 0.78.0"])
  s.add_development_dependency(%q<rubocop-rails>.freeze, ["~> 2.4.1"])
  s.add_development_dependency(%q<rubocop-rspec>.freeze, ["~> 1.37.0"])
  s.add_development_dependency(%q<simplecov>.freeze, ["~> 0.15"])
end
