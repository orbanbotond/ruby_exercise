# -*- encoding: utf-8 -*-
# stub: oedipus_lex 2.6.1 ruby lib

Gem::Specification.new do |s|
  s.name = "oedipus_lex".freeze
  s.version = "2.6.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.metadata = { "homepage_uri" => "http://github.com/seattlerb/oedipus_lex" } if s.respond_to? :metadata=
  s.require_paths = ["lib".freeze]
  s.authors = ["Ryan Davis".freeze]
  s.cert_chain = ["-----BEGIN CERTIFICATE-----\nMIIDPjCCAiagAwIBAgIBBzANBgkqhkiG9w0BAQsFADBFMRMwEQYDVQQDDApyeWFu\nZC1ydWJ5MRkwFwYKCZImiZPyLGQBGRYJemVuc3BpZGVyMRMwEQYKCZImiZPyLGQB\nGRYDY29tMB4XDTIzMDEwMTA3NTExN1oXDTI0MDEwMTA3NTExN1owRTETMBEGA1UE\nAwwKcnlhbmQtcnVieTEZMBcGCgmSJomT8ixkARkWCXplbnNwaWRlcjETMBEGCgmS\nJomT8ixkARkWA2NvbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBALda\nb9DCgK+627gPJkB6XfjZ1itoOQvpqH1EXScSaba9/S2VF22VYQbXU1xQXL/WzCkx\ntaCPaLmfYIaFcHHCSY4hYDJijRQkLxPeB3xbOfzfLoBDbjvx5JxgJxUjmGa7xhcT\noOvjtt5P8+GSK9zLzxQP0gVLS/D0FmoE44XuDr3iQkVS2ujU5zZL84mMNqNB1znh\nGiadM9GHRaDiaxuX0cIUBj19T01mVE2iymf9I6bEsiayK/n6QujtyCbTWsAS9Rqt\nqhtV7HJxNKuPj/JFH0D2cswvzznE/a5FOYO68g+YCuFi5L8wZuuM8zzdwjrWHqSV\ngBEfoTEGr7Zii72cx+sCAwEAAaM5MDcwCQYDVR0TBAIwADALBgNVHQ8EBAMCBLAw\nHQYDVR0OBBYEFEfFe9md/r/tj/Wmwpy+MI8d9k/hMA0GCSqGSIb3DQEBCwUAA4IB\nAQAkg3y+PBnBAPWdxxITm5sPHqdWQgSyCpRA20o4LTuWr8BWhSXBkfQNa7cY6fOn\nxyM34VPzBFbExv6XOGDfOMFBVaYTHuN9peC/5/umL7kLl+nflXzL2QA7K6LYj5Bg\nsM574Onr0dZDM6Vn69bzQ7rBIFDfK/OhlPzqKZad4nsdcsVH8ODCiT+ATMIZyz5K\nWCnNtqlyiWXI8tdTpahDgcUwfcN/oN7v4K8iU5IbLJX6HQ5DKgmKjfb6XyMth16k\nROfWo9Uyp8ba/j9eVG14KkYRaLydAY1MNQk2yd3R5CGfeOpD1kttxjoypoUJ2dOG\nnsNBRuQJ1UfiCG97a6DNm+Fr\n-----END CERTIFICATE-----\n".freeze]
  s.date = "2023-05-31"
  s.description = "Oedipus Lex is a lexer generator in the same family as Rexical and\nRex. Oedipus Lex is my independent lexer fork of Rexical. Rexical was\nin turn a fork of Rex. We've been unable to contact the author of rex\nin order to take it over, fix it up, extend it, and relicense it to\nMIT. So, Oedipus was written clean-room in order to bypass licensing\nconstraints (and because bootstrapping is fun).\n\nOedipus brings a lot of extras to the table and at this point is only\nhistorically related to rexical. The syntax has changed enough that\nany rexical lexer will have to be tweaked to work inside of oedipus.\nAt the very least, you need to add slashes to all your regexps.\n\nOedipus, like rexical, is based primarily on generating code much like\nyou would a hand-written lexer. It is _not_ a table or hash driven\nlexer. It uses StrScanner within a multi-level case statement. As such,\nOedipus matches on the _first_ match, not the longest (like lex and\nits ilk).\n\nThis documentation is not meant to bypass any prerequisite knowledge\non lexing or parsing. If you'd like to study the subject in further\ndetail, please try [TIN321] or the [LLVM Tutorial] or some other good\nresource for CS learning. Books... books are good. I like books.".freeze
  s.email = ["ryand-ruby@zenspider.com".freeze]
  s.extra_rdoc_files = ["History.rdoc".freeze, "Manifest.txt".freeze, "README.rdoc".freeze, "sample/error1.txt".freeze]
  s.files = ["History.rdoc".freeze, "Manifest.txt".freeze, "README.rdoc".freeze, "sample/error1.txt".freeze]
  s.homepage = "http://github.com/seattlerb/oedipus_lex".freeze
  s.licenses = ["MIT".freeze]
  s.rdoc_options = ["--main".freeze, "README.rdoc".freeze]
  s.required_ruby_version = Gem::Requirement.new([">= 2.7".freeze, "< 4.0".freeze])
  s.rubygems_version = "3.4.10".freeze
  s.summary = "Oedipus Lex is a lexer generator in the same family as Rexical and Rex".freeze

  s.installed_by_version = "3.4.10" if s.respond_to? :installed_by_version

  s.specification_version = 4

  s.add_development_dependency(%q<rdoc>.freeze, [">= 4.0", "< 7"])
  s.add_development_dependency(%q<hoe>.freeze, ["~> 4.0"])
end
