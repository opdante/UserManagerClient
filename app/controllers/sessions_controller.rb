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
      :top_schools => auth['info']['top_schools'],
      :last_sign_in_at => auth['info']['last_sign_in_at'],
      :access_token => auth['credentials']['token']
    }
    cookies.signed[:user_manager_client] = { :value => ActiveSupport::JSON.encode(h), :httponly => true, :expires => 2.hours.from_now } #, :domain => "collegezen.com" }
    if session[:return_to]
      redirect_to session[:return_to]
      session[:return_to] = nil
    else
      redirect_to '/'
    end
  end

  def destroy
    if Rails.env.development?
      cookies.delete :user_manager_client
    else
      cookies.delete :user_manager_client, :domain => 'collegezen.com'
    end
    redirect_to "#{UserManagerClient::Engine.config.user_manager_url}/logout"
  end

  def redirect
    redirect_to UserManagerClient::Engine.config.user_manager_auth_url
  end
end
