require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Usermanager < OmniAuth::Strategies::OAuth2

      option :name, :usermanager

      option :client_options, {
        site: UserManagerClient::Engine.config.user_manager_url,
        authorize_path: UserManagerClient::Engine.config.doorkeeper_auth_url
      }

      uid { raw_info['id'] }

      info { raw_info['info'] }
     
      def raw_info
        @info ||= access_token.get(UserManagerClient::Engine.config.user_api_call).parsed
      end
    end 
  end
end