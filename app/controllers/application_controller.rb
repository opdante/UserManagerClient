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

  def current_user
    JSON_decode(cookies.signed[:user_manager_client])
  end
  helper_method :current_user

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

  def photo_url
    JSON_decode(cookies.signed[:user_manager_client])['photo_url']
  end
  helper_method :photo_url

  def email
    JSON_decode(cookies.signed[:user_manager_client])['email']
  end
  helper_method :email

  def role
    JSON_decode(cookies.signed[:user_manager_client])['role']
  end
  helper_method :role

  def find_username(user_id)
    user_manager_access_token.get("/api/v1/users/#{user_id}").parsed['username'] if user_manager_access_token
  end
  helper_method :find_username

  def link_to_user(user_id)
    UserManagerClient::Engine.config.user_manager_url+"/users/#{user_id}"
  end
  helper_method :link_to_user

  def find_first_name(user_id)
    user_manager_access_token.get("/api/v1/users/#{user_id}").parsed['first_name'] if user_manager_access_token
  end
  helper_method :find_first_name   

  def find_last_name(user_id)
    user_manager_access_token.get("/api/v1/users/#{user_id}").parsed['last_name'] if user_manager_access_token
  end
  helper_method :find_last_name    

end
