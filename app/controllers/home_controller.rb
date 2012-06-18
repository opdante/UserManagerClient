class HomeController < UserManagerClientController

	before_filter :check_login

  def index
  	@addresses = access_token.get(UserManagerClient::Engine.config.addresses_api_call).parsed if access_token
  	logger.info(access_token.get(UserManagerClient::Engine.config.user_api_call).parsed)
  end
end
