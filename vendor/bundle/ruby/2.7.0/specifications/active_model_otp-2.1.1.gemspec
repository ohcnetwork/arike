# -*- encoding: utf-8 -*-
# stub: active_model_otp 2.1.1 ruby lib

Gem::Specification.new do |s|
  s.name = "active_model_otp".freeze
  s.version = "2.1.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Guillermo Iguaran".freeze, "Roberto Miranda".freeze, "Heapsource".freeze]
  s.date = "2021-03-07"
  s.description = "Adds methods to set and authenticate against one time passwords 2FA(Two factor Authentication). Inspired in AM::SecurePassword\"".freeze
  s.email = ["guilleiguaran@gmail.com".freeze, "rjmaltamar@gmail.com".freeze, "hello@firebase.co".freeze]
  s.homepage = "".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.3".freeze)
  s.rubygems_version = "3.1.4".freeze
  s.summary = "Adds methods to set and authenticate against one time passwords.".freeze

  s.installed_by_version = "3.1.4" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<activemodel>.freeze, [">= 0"])
    s.add_runtime_dependency(%q<rotp>.freeze, ["~> 6.2.0"])
    s.add_development_dependency(%q<activerecord>.freeze, [">= 0"])
    s.add_development_dependency(%q<rake>.freeze, [">= 0"])
    s.add_development_dependency(%q<minitest>.freeze, ["~> 5.4.2"])
    s.add_development_dependency(%q<appraisal>.freeze, [">= 0"])
    s.add_development_dependency(%q<sqlite3>.freeze, [">= 0"])
  else
    s.add_dependency(%q<activemodel>.freeze, [">= 0"])
    s.add_dependency(%q<rotp>.freeze, ["~> 6.2.0"])
    s.add_dependency(%q<activerecord>.freeze, [">= 0"])
    s.add_dependency(%q<rake>.freeze, [">= 0"])
    s.add_dependency(%q<minitest>.freeze, ["~> 5.4.2"])
    s.add_dependency(%q<appraisal>.freeze, [">= 0"])
    s.add_dependency(%q<sqlite3>.freeze, [">= 0"])
  end
end
