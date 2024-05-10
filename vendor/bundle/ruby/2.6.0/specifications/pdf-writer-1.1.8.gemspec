# -*- encoding: utf-8 -*-
# stub: pdf-writer 1.1.8 ruby lib

Gem::Specification.new do |s|
  s.name = "pdf-writer".freeze
  s.version = "1.1.8"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Austin Ziegler".freeze]
  s.autorequire = "pdf/writer".freeze
  s.date = "2008-03-16"
  s.description = "This library provides the ability to create PDF documents using only native Ruby libraries. There are several demo programs available in the demo/ directory. The canonical documentation for PDF::Writer is \"manual.pdf\", which can be generated using bin/techbook (just \"techbook\" for RubyGem users) and the manual file \"manual.pwd\".".freeze
  s.email = "austin@rubyforge.org".freeze
  s.executables = ["techbook".freeze]
  s.extra_rdoc_files = ["README".freeze, "ChangeLog".freeze, "LICENCE".freeze]
  s.files = ["ChangeLog".freeze, "LICENCE".freeze, "README".freeze, "bin/techbook".freeze]
  s.homepage = "http://rubyforge.org/projects/ruby-pdf".freeze
  s.rdoc_options = ["--title".freeze, "PDF::Writer".freeze, "--main".freeze, "README".freeze, "--line-numbers".freeze]
  s.required_ruby_version = Gem::Requirement.new("> 0.0.0".freeze)
  s.rubygems_version = "3.0.3.1".freeze
  s.summary = "A pure Ruby PDF document creation library.".freeze

  s.installed_by_version = "3.0.3.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 1

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<color>.freeze, [">= 1.4.0"])
      s.add_runtime_dependency(%q<transaction-simple>.freeze, ["~> 1.3"])
    else
      s.add_dependency(%q<color>.freeze, [">= 1.4.0"])
      s.add_dependency(%q<transaction-simple>.freeze, ["~> 1.3"])
    end
  else
    s.add_dependency(%q<color>.freeze, [">= 1.4.0"])
    s.add_dependency(%q<transaction-simple>.freeze, ["~> 1.3"])
  end
end
