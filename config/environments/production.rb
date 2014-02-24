Wpcc::Application.configure do
 
  config.cache_classes = true

  # Full error reports are disabled and caching is turned on
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true 
  config.serve_static_assets = true
 
  config.assets.compress = true 
  config.assets.compile = true 
  config.assets.digest = true
 
  config.force_ssl = false 
  
 # config.action_mailer.default_url_options = { :host => 'wpcc.herokuapp.com' }
 # config.action_mailer.delivery_method = :smtp
 # config.action_mailer.perform_deliveries = true
 # config.action_mailer.raise_delivery_errors = false
 # config.action_mailer.default :charset => "utf-8"
 # config.action_mailer.smtp_settings = {
 #   address: "smtp.gmail.com",
  #  port: 587,
 #   domain: "wpcc.herokuapp.com",
 #   authentication: "plain",
 #   enable_starttls_auto: true,
  #  user_name: ENV["GMAIL_USERNAME"],
  #  password: ENV["GMAIL_PASSWORD"]
  #}
 
  config.i18n.fallbacks = true 
  config.active_support.deprecation = :notify 
end
