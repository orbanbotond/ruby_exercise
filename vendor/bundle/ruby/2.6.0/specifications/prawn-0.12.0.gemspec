# -*- encoding: utf-8 -*-
# stub: prawn 0.12.0 ruby lib

Gem::Specification.new do |s|
  s.name = "prawn".freeze
  s.version = "0.12.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.3.6".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Gregory Brown".freeze, "Brad Ediger".freeze, "Daniel Nelson".freeze, "Jonathan Greenberg".freeze, "James Healy".freeze]
  s.date = "2011-08-13"
  s.description = "  Prawn is a fast, tiny, and nimble PDF generator for Ruby\n".freeze
  s.email = ["gregory.t.brown@gmail.com".freeze, "brad@bradediger.com".freeze, "dnelson@bluejade.com".freeze, "greenberg@entryway.net".freeze, "jimmy@deefa.com".freeze]
  s.extra_rdoc_files = ["README.md".freeze, "LICENSE".freeze, "COPYING".freeze, "GPLv2".freeze, "GPLv3".freeze]
  s.files = ["COPYING".freeze, "GPLv2".freeze, "GPLv3".freeze, "LICENSE".freeze, "README.md".freeze]
  s.homepage = "http://prawn.majesticseacreature.com".freeze
  s.post_install_message = "\n  ********************************************\n\n\n  A lot has changed since 0.8.4\n\n  Please read the changelog for details:\n\n  https://github.com/sandal/prawn/wiki/CHANGELOG\n\n\n  ********************************************\n\n".freeze
  s.rdoc_options = ["--title".freeze, "Prawn Documentation".freeze, "--main".freeze, "README".freeze, "-q".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 1.8.7".freeze)
  s.rubygems_version = "3.0.3.1".freeze
  s.summary = "A fast and nimble PDF generator for Ruby".freeze

  s.installed_by_version = "3.0.3.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<pdf-reader>.freeze, [">= 0.9.0"])
      s.add_runtime_dependency(%q<ttfunk>.freeze, ["~> 1.0.2"])
    else
      s.add_dependency(%q<pdf-reader>.freeze, [">= 0.9.0"])
      s.add_dependency(%q<ttfunk>.freeze, ["~> 1.0.2"])
    end
  else
    s.add_dependency(%q<pdf-reader>.freeze, [">= 0.9.0"])
    s.add_dependency(%q<ttfunk>.freeze, ["~> 1.0.2"])
  end
end
