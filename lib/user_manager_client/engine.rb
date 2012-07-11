module UserManagerClient
  class Engine < ::Rails::Engine
    require 'omniauth-oauth2'

    initializer "api.init_task", :before => :load_config_initializers do |app|
      UserManagerClientConfig = Struct.new(:api_key, :api_secret)
      app.config.user_manager_client = UserManagerClientConfig.new
      app.config.user_manager_client.api_key = ""
      app.config.user_manager_client.api_secret = ""
    end

  	self.configure do
  		if Rails.env.development?
<<<<<<< HEAD
		  	config.api_key = 'cf4a0787d161ebb2ec67729c8e47fe3a5a5d5758b777ca559c72a1246c4bd08e'
				config.api_secret = 'ca18ea2e9c40892725d1af4380afc6d0b5f33e390fe16a1c56acb3f9d2fa8ca3'
				config.user_manager_url = 'http://localhost:3001'
        config.colleges_url = 'http://localhost:3000'
=======
				config.user_manager_url = 'http://localhost:3000'
        config.colleges_url = 'http://localhost:3002'
>>>>>>> 8aa41a3ea0c7d06e31fb0b9c3fbb68e5a6baeff8
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
