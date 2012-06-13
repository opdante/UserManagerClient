require UserManagerClient::Engine.config.root + 'app' + 'controllers' + 'application_controller'

class ApplicationController < ActionController::Base
  protect_from_forgery
end
