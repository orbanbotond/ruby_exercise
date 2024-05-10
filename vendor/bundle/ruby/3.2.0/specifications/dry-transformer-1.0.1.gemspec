# -*- encoding: utf-8 -*-
# stub: dry-transformer 1.0.1 ruby lib

Gem::Specification.new do |s|
  s.name = "dry-transformer".freeze
  s.version = "1.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.metadata = { "allowed_push_host" => "https://rubygems.org", "bug_tracker_uri" => "https://github.com/dry-rb/dry-transformer/issues", "changelog_uri" => "https://github.com/dry-rb/dry-transformer/blob/main/CHANGELOG.md", "source_code_uri" => "https://github.com/dry-rb/dry-transformer" } if s.respond_to? :metadata=
  s.require_paths = ["lib".freeze]
  s.authors = ["Piotr Solnica".freeze]
  s.date = "2022-11-23"
  s.description = "Data transformation toolkit".freeze
  s.email = ["piotr.solnica@gmail.com".freeze]
  s.homepage = "https://dry-rb.org/gems/dry-transformer".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.7.0".freeze)
  s.rubygems_version = "3.4.10".freeze
  s.summary = "Data transformation toolkit".freeze

  s.installed_by_version = "3.4.10" if s.respond_to? :installed_by_version

  s.specification_version = 4

  s.add_runtime_dependency(%q<zeitwerk>.freeze, ["~> 2.6"])
end
