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
        config.user_manager_url = 'http://localhost:3000'
        config.colleges_url = 'http://localhost:3002'
		  else
		  	config.user_manager_url = 'http://account.collegezen.net'
        config.colleges_url = 'http://localhost:3002'
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
