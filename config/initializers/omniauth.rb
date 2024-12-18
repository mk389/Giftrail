Rails.application.config.middleware.use OmniAuth::Builder do
  OmniAuth.config.allowed_request_methods = [:get, :post]
  OmniAuth.config.logger = Rails.logger
  OmniAuth.config.silence_get_warning = true
end