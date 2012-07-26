class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :logged_in?, :check_login, :current_user, :user_id, :username,
                :high_school_id, :college_id, :first_name, :last_name, :email,
                :role, :find_username, :link_to_user, :find_first_name,
                :find_last_name, :find_email, :find_college, :find_user,
                :find_counselors, :find_hs_students

  rescue_from OAuth2::Error do |exception|
    if exception.response.status == 401
      cookies.delete :user_manager_client
      redirect_to root_url, alert: "Access token expired, try signing in again."
    end
  end

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

  def logged_in?
    return !(cookies.signed[:user_manager_client].blank? ||
            JSON_decode(cookies.signed[:user_manager_client]).blank? ||
            JSON_decode(cookies.signed[:user_manager_client])['user_id'].blank?)
  end

  def check_login
    redirect_to UserManagerClient::Engine.config.user_manager_auth_url unless logged_in?
  end

  def current_user
    JSON_decode(cookies.signed[:user_manager_client])
  end

  def user_id
    JSON_decode(cookies.signed[:user_manager_client])['user_id']
  end

  def username
    JSON_decode(cookies.signed[:user_manager_client])['username']
  end

  def high_school_id
    JSON_decode(cookies.signed[:user_manager_client])['high_school_id']
  end

  def college_id
    JSON_decode(cookies.signed[:user_manager_client])['college_id']
  end

  def first_name
    JSON_decode(cookies.signed[:user_manager_client])['first_name']
  end

  def last_name
    JSON_decode(cookies.signed[:user_manager_client])['last_name']
  end

  def photo_url
    JSON_decode(cookies.signed[:user_manager_client])['photo_url']
  end

  def email
    JSON_decode(cookies.signed[:user_manager_client])['email']
  end

  def role
    JSON_decode(cookies.signed[:user_manager_client])['role']
  end

  def find_username(user_id)
    user_manager_access_token.get("/api/v1/users/#{user_id}").parsed['username'] if user_manager_access_token
  end

  def link_to_user(user_id)
    UserManagerClient::Engine.config.user_manager_url+"/users/#{user_id}"
  end

  def find_first_name(user_id)
    user_manager_access_token.get("/api/v1/users/#{user_id}").parsed['first_name'] if user_manager_access_token
  end

  def find_last_name(user_id)
    user_manager_access_token.get("/api/v1/users/#{user_id}").parsed['last_name'] if user_manager_access_token
  end

  def find_email(user_id)
    user_manager_access_token.get("/api/v1/users/#{user_id}").parsed['email'] if user_manager_access_token
  end

  def find_college(user_id)
    user_manager_access_token.get("/api/v1/users/#{user_id}").parsed['college_id'] if user_manager_access_token
  end

  def find_user(user_id)
    user_manager_access_token.get("/api/v1/users/#{user_id}") if user_manager_access_token
  end

  def find_counselors(high_school_id)
    user_manager_access_token.get("/api/v1/users/for_hs_counselor?id=#{high_school_id}").parsed['first_name', 'last_name'] if user_manager_access_token
  end

  def find_hs_students(high_school_id)
    user_manager_access_token.get("/api/v1/users/for_hs_student?id=#{high_school_id}").parsed if user_manager_access_token
  end

end
