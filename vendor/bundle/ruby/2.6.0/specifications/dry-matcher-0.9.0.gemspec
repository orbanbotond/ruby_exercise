# -*- encoding: utf-8 -*-
# stub: dry-matcher 0.9.0 ruby lib

Gem::Specification.new do |s|
  s.name = "dry-matcher".freeze
  s.version = "0.9.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.metadata = { "allowed_push_host" => "https://rubygems.org", "bug_tracker_uri" => "https://github.com/dry-rb/dry-matcher/issues", "changelog_uri" => "https://github.com/dry-rb/dry-matcher/blob/master/CHANGELOG.md", "source_code_uri" => "https://github.com/dry-rb/dry-matcher" } if s.respond_to? :metadata=
  s.require_paths = ["lib".freeze]
  s.authors = ["Tim Riley".freeze, "Nikita Shilnikov".freeze]
  s.date = "2021-03-05"
  s.description = "Flexible, expressive pattern matching for Ruby".freeze
  s.email = ["tim@icelab.com.au".freeze, "fg@flashgordon.ru".freeze]
  s.homepage = "https://dry-rb.org/gems/dry-matcher".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.5.0".freeze)
  s.rubygems_version = "3.0.3.1".freeze
  s.summary = "Flexible, expressive pattern matching for Ruby".freeze

  s.installed_by_version = "3.0.3.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<dry-core>.freeze, ["~> 0.4", ">= 0.4.8"])
      s.add_development_dependency(%q<rake>.freeze, [">= 0"])
    else
      s.add_dependency(%q<dry-core>.freeze, ["~> 0.4", ">= 0.4.8"])
      s.add_dependency(%q<rake>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<dry-core>.freeze, ["~> 0.4", ">= 0.4.8"])
    s.add_dependency(%q<rake>.freeze, [">= 0"])
  end
end