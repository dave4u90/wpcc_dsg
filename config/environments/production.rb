  Wpcc::Application.configure do

  config.cache_classes = true

  # Full error reports are disabled and caching is turned on
  config.consider_all_requests_local = false
  config.action_controller.perform_caching = true
  config.serve_static_assets = true

  config.assets.compress = true
  config.assets.compile = true
  config.assets.digest = true

  config.force_ssl = false

  config.action_mailer.default_url_options = {:host => 'ancient-spire-8093.herokuapp.com'}
  # config.action_mailer.delivery_method = :smtp
  # config.action_mailer.perform_deliveries = true
  config.action_mailer.raise_delivery_errors = true
  ActionMailer::Base.smtp_settings = {
      :address => "smtp.workplacecarecentre.com",
      :port => 587,
      :authentication => :plain,
      :user_name => 'admin@workplacecarecentre.com',
      :password => ' WbZ8FT~2',
      :enable_starttls_auto => false
  }

  config.i18n.fallbacks = true
  config.active_support.deprecation = :notify
end
