Rails.application.config.middleware.use OmniAuth::Builder do
	provider :usermanager, UserManagerClient::Engine.config.user_manager_client.api_key, UserManagerClient::Engine.config.user_manager_client.api_secret
end