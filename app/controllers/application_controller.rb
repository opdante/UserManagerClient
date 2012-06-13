class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from OAuth2::Error do |exception|
    if exception.response.status == 401
      cookies.delete :uid
      cookies.delete :access_token
      redirect_to root_url, alert: "Access token expired, try signing in again."
    end
  end

private

  def oauth_client
    @oauth_client ||= OAuth2::Client.new(UserManagerClient::Engine.config.api_key, UserManagerClient::Engine.config.api_secret, site: UserManagerClient::Engine.config.user_manager_url)
  end

  def access_token
    if cookies.signed[:access_token]
      @access_token ||= OAuth2::AccessToken.new(oauth_client, cookies.signed[:access_token])
    end
  end

  def check_login
    if cookies.signed[:uid].nil?
      redirect_to UserManagerClient::Engine.config.user_manager_auth_url
    end
  end
  helper_method :check_login

  def logged_in?
    if cookies.signed[:uid].nil?
      return false
    end
    return true
  end
  helper_method :logged_in?

  def uid
    cookies.signed[:uid]
  end
  helper_method :uid

  def high_school_id
    cookies.signed[:high_school_id]
  end
  helper_method :high_school_id

  def college_id
    cookies.signed[:college_id]
  end
  helper_method :college_id  

  def first_name
    cookies.signed[:first_name]
  end
  helper_method :first_name

  def last_name
    cookies.signed[:last_name]
  end
  helper_method :last_name

  def email
    cookies.signed[:email]
  end
  helper_method :email

  def role
    cookies.signed[:role]
  end
  helper_method :role

end
