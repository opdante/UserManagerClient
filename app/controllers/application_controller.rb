class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from OAuth2::Error do |exception|
    if exception.response.status == 401
      cookies.delete :user_manager_client
      redirect_to root_url, alert: "Access token expired, try signing in again."
    end
  end

private

  def JSON_decode(string)
    ActiveSupport::JSON.decode(string)
  end

  def oauth_client
    @oauth_client ||= OAuth2::Client.new(UserManagerClient::Engine.config.user_manager_client.api_key, UserManagerClient::Engine.config.user_manager_client.api_secret, site: UserManagerClient::Engine.config.user_manager_url)
  end

  def user_manager_access_token
    if JSON_decode(cookies.signed[:user_manager_client])['access_token']
      @user_manager_access_token ||= OAuth2::AccessToken.new(oauth_client, JSON_decode(cookies.signed[:user_manager_client])['access_token'])
    end
  end

end
