Gem::Specification.new do |s|
  s.name = "web-push-notification-rails"
  s.version = "0.2.0"
  s.authors = ["Ankur Patel"]
  s.date = %q[2013-11-07]
  s.description = "Apple Web Push Notifications Package Generator"
  s.summary = s.description
  s.email = 'ankur.patel@ymail.com'
  s.files = Dir.glob('{lib}/**/*')
  s.homepage = 'https://github.com/ankurp/apple-web-push-notification-rails'
  s.licenses = 'MIT'
  s.has_rdoc = false
  s.required_ruby_version = '>=2.0.0'
  s.rubyforge_project = 'web-push-notification-rails'
  s.add_dependency "rails", ">= 3.1.0"
  s.add_dependency "json"
  s.add_dependency 'rubyzip', '< 1.0.0'
  s.add_runtime_dependency "activesupport", ">= 3.0"
  s.add_development_dependency 'rspec', '>2.0'
  s.add_development_dependency 'rake'
end