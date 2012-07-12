def logged_in?
  return !(cookies.signed[:user_manager_client].blank? ||
          JSON_decode(cookies.signed[:user_manager_client]).blank? ||
          JSON_decode(cookies.signed[:user_manager_client])['user_id'].blank?)
end

def check_login
  if logged_in?
    redirect_to UserManagerClient::Engine.config.user_manager_auth_url
  end
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

def find_college(user_id)
  user_manager_access_token.get("/api/v1/users/#{user_id}").parsed['college_id'] if user_manager_access_token
end

def find_user(user_id)
  user_manager_access_token.get("/api/v1/users/#{user_id}") if user_manager_access_token
end