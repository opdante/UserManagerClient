class SessionsController < ApplicationController

  def create
    reset_session
    auth = request.env["omniauth.auth"]
    logger.debug "COOKIE EXPIRES IN"
    logger.info(2.hours.from_now)
    # cookies.signed[:user_id] = { :value => auth['uid'], :httponly => true, :expires => 2.hours.from_now }
    # cookies.signed[:username] = { :value => auth['info']['username'], :httponly => true, :expires => 2.hours.from_now }
    # cookies.signed[:first_name] = { :value => auth['info']['first_name'], :httponly => true, :expires => 2.hours.from_now }
    # cookies.signed[:last_name] = { :value => auth['info']['last_name'], :httponly => true, :expires => 2.hours.from_now }
    # cookies.signed[:email] = { :value => auth['info']['email'], :httponly => true, :expires => 2.hours.from_now }
    # cookies.signed[:role] = { :value => auth['info']['role'], :httponly => true, :expires => 2.hours.from_now }
    # cookies.signed[:college_id] = { :value => auth['info']['college_id'], :httponly => true, :expires => 2.hours.from_now }
    # cookies.signed[:high_school_id] = { :value => auth['info']['high_school_id'], :httponly => true, :expires => 2.hours.from_now }
    # cookies.signed[:photo_url] = { :value => auth['info']['photo_url'], :httponly => true, :expires => 2.hours.from_now }
    # cookies.signed[:user_manager_access_token] = { :value => auth['credentials']['token'], :httponly => true, :expires => 2.hours.from_now }
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
    logger.info("COOKIE")
    logger.info(cookies.signed[:user_manager_client])
    logger.info(ActiveSupport::JSON.decode(cookies.signed[:user_manager_client]))

    logger.info(ActiveSupport::JSON.decode(cookies.signed[:user_manager_client])['access_token'])
    redirect_to root_url
  end

  def destroy
    cookies.delete :user_manager_client
    # cookies.delete :user_id
    # cookies.delete :username
    # cookies.delete :first_name
    # cookies.delete :last_name
    # cookies.delete :email
    # cookies.delete :role
    # cookies.delete :college_id
    # cookies.delete :high_school_id
    # cookies.delete :photo_url
    # cookies.delete :user_manager_access_token
    redirect_to "#{UserManagerClient::Engine.config.user_manager_url}/logout"
  end
end
