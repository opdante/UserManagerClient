module UserManagerClient
  class Engine < ::Rails::Engine
    require 'omniauth-oauth2'

    self.configure do
      if Rails.env.development?
        config.api_key = 'USER_MANAGER_KEY'
      config.api_secret = 'USER_MANAGER_SECRET'
      config.user_manager_url = 'http://localhost:4000'
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
