# -*- encoding: utf-8 -*-
# stub: dry-transaction 0.13.3 ruby lib

Gem::Specification.new do |s|
  s.name = "dry-transaction".freeze
  s.version = "0.13.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.metadata = { "allowed_push_host" => "https://rubygems.org", "bug_tracker_uri" => "https://github.com/dry-rb/dry-transaction/issues", "changelog_uri" => "https://github.com/dry-rb/dry-transaction/blob/master/CHANGELOG.md", "source_code_uri" => "https://github.com/dry-rb/dry-transaction" } if s.respond_to? :metadata=
  s.require_paths = ["lib".freeze]
  s.authors = ["Tim Riley".freeze]
  s.date = "2021-06-07"
  s.description = "Business Transaction Flow DSL".freeze
  s.email = ["tim@icelab.com.au".freeze]
  s.homepage = "https://dry-rb.org/gems/dry-transaction".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.6.0".freeze)
  s.rubygems_version = "3.0.3.1".freeze
  s.summary = "Business Transaction Flow DSL".freeze

  s.installed_by_version = "3.0.3.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<dry-container>.freeze, [">= 0.2.8"])
      s.add_runtime_dependency(%q<dry-events>.freeze, [">= 0.1.0"])
      s.add_runtime_dependency(%q<dry-matcher>.freeze, [">= 0.7.0"])
      s.add_runtime_dependency(%q<dry-monads>.freeze, [">= 0.4.0"])
    else
      s.add_dependency(%q<dry-container>.freeze, [">= 0.2.8"])
      s.add_dependency(%q<dry-events>.freeze, [">= 0.1.0"])
      s.add_dependency(%q<dry-matcher>.freeze, [">= 0.7.0"])
      s.add_dependency(%q<dry-monads>.freeze, [">= 0.4.0"])
    end
  else
    s.add_dependency(%q<dry-container>.freeze, [">= 0.2.8"])
    s.add_dependency(%q<dry-events>.freeze, [">= 0.1.0"])
    s.add_dependency(%q<dry-matcher>.freeze, [">= 0.7.0"])
    s.add_dependency(%q<dry-monads>.freeze, [">= 0.4.0"])
  end
end
