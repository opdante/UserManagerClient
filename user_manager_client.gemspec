$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "user_manager_client/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "user_manager_client"
  s.version     = UserManagerClient::VERSION
  s.authors     = ["Yihuan Zhou", "Jonathan Bender", "Thabang Ngazimbi"]
  s.email       = ["yihuan.zhou@gmail.com", "support@thecollegepeople.com"]
  s.homepage    = "http://www.collegezen.com"
  s.summary     = "Provides access to the UserManager API"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.5"
  s.add_dependency "omniauth-oauth2"
  # s.add_dependency "jquery-rails"

  s.add_development_dependency "sqlite3"
end
