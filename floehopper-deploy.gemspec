# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{floehopper-deploy}
  s.version = "0.1.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["James Mead"]
  s.date = %q{2011-05-09}
  s.email = %q{james@floehopper.org}
  s.files = ["Gemfile", "lib/floehopper", "lib/floehopper/deploy.rb", "puppet/floehopper", "puppet/floehopper/manifests", "puppet/floehopper/manifests/init.pp", "puppet/floehopper/templates", "puppet/floehopper/templates/rails-vhost.erb", "puppet/floehopper/templates/static-vhost.erb"]
  s.homepage = %q{http://jamesmead.org}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Makes deploying my apps much simpler}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<freerange-deploy>, [">= 0"])
      s.add_runtime_dependency(%q<freerange-puppet>, [">= 0"])
    else
      s.add_dependency(%q<freerange-deploy>, [">= 0"])
      s.add_dependency(%q<freerange-puppet>, [">= 0"])
    end
  else
    s.add_dependency(%q<freerange-deploy>, [">= 0"])
    s.add_dependency(%q<freerange-puppet>, [">= 0"])
  end
end
