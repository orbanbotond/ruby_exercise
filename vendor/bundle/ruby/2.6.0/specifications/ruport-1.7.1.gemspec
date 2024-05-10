# -*- encoding: utf-8 -*-
# stub: ruport 1.7.1 ruby lib

Gem::Specification.new do |s|
  s.name = "ruport".freeze
  s.version = "1.7.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Gregory Brown".freeze, "Mike Milner".freeze, "Andrew France".freeze]
  s.date = "2017-05-02"
  s.description = "Ruby Reports is a software library that aims to make the task of reporting\n      less tedious and painful. It provides tools for data acquisition,\n      database interaction, formatting, and parsing/munging.\n".freeze
  s.email = "gregory.t.brown@gmail.com".freeze
  s.extra_rdoc_files = ["LICENSE".freeze, "README.rdoc".freeze]
  s.files = ["LICENSE".freeze, "README.rdoc".freeze]
  s.homepage = "http://github.com/ruport/ruport".freeze
  s.rdoc_options = ["--title".freeze, "Ruport Documentation".freeze, "--main".freeze, "README.rdoc".freeze, "-q".freeze]
  s.rubygems_version = "3.0.3.1".freeze
  s.summary = "A generalized Ruby report generation and templating engine.".freeze

  s.installed_by_version = "3.0.3.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<pdf-writer>.freeze, ["= 1.1.8"])
      s.add_runtime_dependency(%q<prawn>.freeze, ["= 0.12.0"])
      s.add_development_dependency(%q<rake>.freeze, [">= 0"])
    else
      s.add_dependency(%q<pdf-writer>.freeze, ["= 1.1.8"])
      s.add_dependency(%q<prawn>.freeze, ["= 0.12.0"])
      s.add_dependency(%q<rake>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<pdf-writer>.freeze, ["= 1.1.8"])
    s.add_dependency(%q<prawn>.freeze, ["= 0.12.0"])
    s.add_dependency(%q<rake>.freeze, [">= 0"])
  end
end
