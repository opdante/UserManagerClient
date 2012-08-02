if !Rails.env.development?
  Rails.configuration.session_store :cookie_store, {
    :domain => ".collegezen.net"
  }
end