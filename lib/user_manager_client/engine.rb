module UserManagerClient
  class Engine < ::Rails::Engine
  	require 'omniauth-oauth2'

  	self.configure do
  		if Rails.env.development?
		  	config.api_key = 'e512a873a592eb70675ac552355398c11c01e4db0d56128ca62a41840f8db501'
				config.api_secret = '0dfa67c44e3652c09982741fb1573681a4c69b0c70da1c1538671637d12fbfd3'
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
