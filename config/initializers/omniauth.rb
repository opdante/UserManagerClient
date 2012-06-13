Rails.application.config.middleware.use OmniAuth::Builder do
	provider :usermanager, UserManagerClient::Engine.config.api_key, UserManagerClient::Engine.config.api_secret
end