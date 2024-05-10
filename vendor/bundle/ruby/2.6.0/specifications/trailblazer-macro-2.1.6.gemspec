# -*- encoding: utf-8 -*-
# stub: trailblazer-macro 2.1.6 ruby lib

Gem::Specification.new do |s|
  s.name = "trailblazer-macro".freeze
  s.version = "2.1.6"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Nick Sutterer".freeze, "Marc Tich".freeze]
  s.date = "2021-03-11"
  s.description = "Macros for Trailblazer's operation".freeze
  s.email = ["apotonick@gmail.com".freeze, "marc@mudsu.com".freeze]
  s.homepage = "http://trailblazer.to".freeze
  s.licenses = ["LGPL-3.0".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.2.0".freeze)
  s.rubygems_version = "3.0.3.1".freeze
  s.summary = "Macros for Trailblazer's operation: Policy, Wrap, Rescue and more.".freeze

  s.installed_by_version = "3.0.3.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<bundler>.freeze, [">= 0"])
      s.add_development_dependency(%q<minitest>.freeze, [">= 0"])
      s.add_development_dependency(%q<rake>.freeze, [">= 0"])
      s.add_development_dependency(%q<multi_json>.freeze, [">= 0"])
      s.add_development_dependency(%q<roar>.freeze, [">= 0"])
      s.add_development_dependency(%q<trailblazer-developer>.freeze, [">= 0"])
      s.add_runtime_dependency(%q<trailblazer-activity-dsl-linear>.freeze, [">= 0.4.0", "< 0.5.0"])
      s.add_runtime_dependency(%q<trailblazer-operation>.freeze, [">= 0.7.0"])
    else
      s.add_dependency(%q<bundler>.freeze, [">= 0"])
      s.add_dependency(%q<minitest>.freeze, [">= 0"])
      s.add_dependency(%q<rake>.freeze, [">= 0"])
      s.add_dependency(%q<multi_json>.freeze, [">= 0"])
      s.add_dependency(%q<roar>.freeze, [">= 0"])
      s.add_dependency(%q<trailblazer-developer>.freeze, [">= 0"])
      s.add_dependency(%q<trailblazer-activity-dsl-linear>.freeze, [">= 0.4.0", "< 0.5.0"])
      s.add_dependency(%q<trailblazer-operation>.freeze, [">= 0.7.0"])
    end
  else
    s.add_dependency(%q<bundler>.freeze, [">= 0"])
    s.add_dependency(%q<minitest>.freeze, [">= 0"])
    s.add_dependency(%q<rake>.freeze, [">= 0"])
    s.add_dependency(%q<multi_json>.freeze, [">= 0"])
    s.add_dependency(%q<roar>.freeze, [">= 0"])
    s.add_dependency(%q<trailblazer-developer>.freeze, [">= 0"])
    s.add_dependency(%q<trailblazer-activity-dsl-linear>.freeze, [">= 0.4.0", "< 0.5.0"])
    s.add_dependency(%q<trailblazer-operation>.freeze, [">= 0.7.0"])
  end
end
