Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook,
    Rails.configuration.facebook['app_id'],
    Rails.configuration.facebook['secret'],
    scope: 'email',
    client_options: {
      site: "https://graph.facebook.com/v2.2",
      authorize_url: "https://www.facebook.com/v2.2/dialog/oauth"
    }
end

OmniAuth.config.logger = Rails.logger
