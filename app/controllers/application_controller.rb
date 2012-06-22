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
    @oauth_client ||= OAuth2::Client.new(UserManagerClient::Engine.config.api_key, UserManagerClient::Engine.config.api_secret, site: UserManagerClient::Engine.config.user_manager_url)
  end

  def user_manager_access_token
    if JSON_decode(cookies.signed[:user_manager_client])['access_token']
      @user_manager_access_token ||= OAuth2::AccessToken.new(oauth_client, JSON_decode(cookies.signed[:user_manager_client])['access_token'])
    end
  end

  def check_login
    if cookies.signed[:user_manager_client].blank? || JSON_decode(cookies.signed[:user_manager_client]).blank? || JSON_decode(cookies.signed[:user_manager_client])['user_id'].blank?
      redirect_to UserManagerClient::Engine.config.user_manager_auth_url
    end
  end
  helper_method :check_login

  def logged_in?
    if cookies.signed[:user_manager_client].blank? || JSON_decode(cookies.signed[:user_manager_client]).blank? || JSON_decode(cookies.signed[:user_manager_client])['user_id'].blank?
      return false
    end
    return true
  end
  helper_method :logged_in?

  def user_id
    JSON_decode(cookies.signed[:user_manager_client])['user_id']
  end
  helper_method :user_id

  def username
    JSON_decode(cookies.signed[:user_manager_client])['username']
  end
  helper_method :username

  def high_school_id
    JSON_decode(cookies.signed[:user_manager_client])['high_school_id']
  end
  helper_method :high_school_id

  def college_id
    JSON_decode(cookies.signed[:user_manager_client])['college_id']
  end
  helper_method :college_id  

  def first_name
    JSON_decode(cookies.signed[:user_manager_client])['first_name']
  end
  helper_method :first_name

  def last_name
    JSON_decode(cookies.signed[:user_manager_client])['last_name']
  end
  helper_method :last_name

  def email
    JSON_decode(cookies.signed[:user_manager_client])['email']
  end
  helper_method :email

  def role
    JSON_decode(cookies.signed[:user_manager_client])['role']
  end
  helper_method :role

end
