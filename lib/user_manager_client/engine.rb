module UserManagerClient
  class Engine < ::Rails::Engine
  	require 'omniauth-oauth2'

  	self.configure do
  		if Rails.env.development?
		  	config.api_key = '9d9ffbf8dc6dd5ddceb97382455e831ccef9222040e19cef43b49a9fd51b9a79'
				config.api_secret = 'acc9b4f95be918a1c0c138f27612b31bd2fa05cb55c0505644a4125af2d7dcd1'
				config.user_manager_url = 'http://localhost:3000'
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
