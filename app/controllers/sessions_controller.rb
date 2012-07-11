class SessionsController < ApplicationController

  def create
    reset_session
    auth = request.env["omniauth.auth"]
    h = Hash.new
    h = {
      :user_id => auth['uid'],
      :username => auth['info']['username'], 
      :first_name => auth['info']['first_name'],
      :last_name => auth['info']['last_name'],
      :email => auth['info']['email'],
      :role => auth['info']['role'],
      :college_id => auth['info']['college_id'],
      :high_school_id => auth['info']['high_school_id'],
      :photo_url => auth['info']['photo_url'],
      :access_token => auth['credentials']['token']
    }
    cookies.signed[:user_manager_client] = { :value => ActiveSupport::JSON.encode(h), :httponly => true, :expires => 2.hours.from_now }
    redirect_to root_url
  end

  def destroy
    cookies.delete :user_manager_client
    redirect_to "#{UserManagerClient::Engine.config.user_manager_url}/logout"
  end

  def redirect
    redirect_to UserManagerClient::Engine.config.user_manager_auth_url
  end
end
