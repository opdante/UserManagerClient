module UserManagerClient
  class Engine < ::Rails::Engine
  	require 'omniauth-oauth2'

  	self.configure do
	  if Rails.env.development?
	    config.api_key = 'ada206db50c28c4b54c508e058a10e871857996bfbd0504f4edae69bfa0d829d'
	    config.api_secret = '9de4b1baa2135872102d2d5e30b77d8a40aa95857468b3a0c145bc59510df4a0'
	    config.user_manager_url = 'http://localhost:3000'
            config.colleges_url = 'http://localhost:3002'
	  elsif Rails.env.production?
	    config.api_key = ''
	    config.api_secret = ''
	    config.user_manager_url = ''
	  end
	  config.user_manager_users_url = config.user_manager_url+'/users/'	
	  config.user_manager_auth_url = '/auth/usermanager'
	  config.doorkeeper_auth_url = '/oauth/authorize'
	  config.user_api_call = '/api/v1/users'
	  config.addresses_api_call = '/api/v1/users/addresses'
	  config.high_school_info_api_call = '/api/v1/users/high_school_info'
	  config.college_info_api_call = '/api/v1/users/college_info'
	end
  end
end
