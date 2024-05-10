# -*- encoding: utf-8 -*-
# stub: dry-events 0.3.0 ruby lib

Gem::Specification.new do |s|
  s.name = "dry-events".freeze
  s.version = "0.3.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.metadata = { "allowed_push_host" => "https://rubygems.org", "bug_tracker_uri" => "https://github.com/dry-rb/dry-events/issues", "changelog_uri" => "https://github.com/dry-rb/dry-events/blob/master/CHANGELOG.md", "source_code_uri" => "https://github.com/dry-rb/dry-events" } if s.respond_to? :metadata=
  s.require_paths = ["lib".freeze]
  s.authors = ["Piotr Solnica".freeze]
  s.date = "2021-04-11"
  s.description = "Pub/sub system".freeze
  s.email = ["piotr.solnica+oss@gmail.com".freeze]
  s.homepage = "https://dry-rb.org/gems/dry-events".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.5.0".freeze)
  s.rubygems_version = "3.4.10".freeze
  s.summary = "Pub/sub system".freeze

  s.installed_by_version = "3.4.10" if s.respond_to? :installed_by_version

  s.specification_version = 4

  s.add_runtime_dependency(%q<concurrent-ruby>.freeze, ["~> 1.0"])
  s.add_runtime_dependency(%q<dry-core>.freeze, ["~> 0.5", ">= 0.5"])
  s.add_development_dependency(%q<bundler>.freeze, [">= 0"])
  s.add_development_dependency(%q<rake>.freeze, [">= 0"])
  s.add_development_dependency(%q<rspec>.freeze, [">= 0"])
end