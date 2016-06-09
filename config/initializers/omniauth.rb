Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, Rails.configuration.facebook['app_id'], Rails.configuration.facebook['secret'], scope: 'email'
end

OmniAuth.config.logger = Rails.logger
