# -*- encoding: utf-8 -*-
# stub: trailblazer-context 0.5.1 ruby lib

Gem::Specification.new do |s|
  s.name = "trailblazer-context".freeze
  s.version = "0.5.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Nick Sutterer".freeze]
  s.date = "2022-10-09"
  s.description = "Argument-specific data structures for Trailblazer such as Context and ContainerChain.".freeze
  s.email = ["apotonick@gmail.com".freeze]
  s.homepage = "https://trailblazer.to/".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.1.0".freeze)
  s.rubygems_version = "3.4.10".freeze
  s.summary = "Argument-specific data structures for Trailblazer.".freeze

  s.installed_by_version = "3.4.10" if s.respond_to? :installed_by_version

  s.specification_version = 4

  s.add_runtime_dependency(%q<hashie>.freeze, [">= 3.0.0"])
  s.add_development_dependency(%q<bundler>.freeze, [">= 0"])
  s.add_development_dependency(%q<minitest>.freeze, [">= 0"])
  s.add_development_dependency(%q<rake>.freeze, [">= 0"])
end
