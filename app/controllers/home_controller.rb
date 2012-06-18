class HomeController < ApplicationController

	before_filter :check_login

  def index
  	@addresses = user_manager_access_token.get(UserManagerClient::Engine.config.addresses_api_call).parsed if user_manager_access_token
  	logger.info(user_manager_access_token.get(UserManagerClient::Engine.config.user_api_call).parsed)
  end
end
