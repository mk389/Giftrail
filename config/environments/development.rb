Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  config.enable_reloading = true
  config.eager_load = false
  config.consider_all_requests_local = true
  config.server_timing = true

  if Rails.root.join("tmp/caching-dev.txt").exist?
    config.action_controller.perform_caching = true
    config.cache_store = :memory_store
    config.public_file_server.headers = { "Cache-Control" => "public, max-age=#{2.days.to_i}" }
  else
    config.action_controller.perform_caching = false
    config.cache_store = :null_store
  end

  config.action_mailer.raise_delivery_errors = false
  config.action_mailer.perform_caching = false
  config.action_mailer.default_url_options = { host: "localhost", port: 3000 }
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    address:              ENV.fetch('MAIL_ADDRESS', 'localhost'),
    port:                 ENV.fetch('MAIL_PORT', 587),
    domain:               ENV.fetch('MAIL_DOMAIN', 'example.com'),
    user_name:            ENV.fetch('MAIL_USERNAME', nil),
    password:             ENV.fetch('MAIL_PASSWORD', nil),
    authentication:       ENV.fetch('MAIL_AUTHENTICATION', 'plain'),
    enable_starttls_auto: ENV.fetch('MAIL_ENABLE_STARTTLS_AUTO', 'true') == 'true'
  }

  config.active_support.deprecation = :log
  config.active_record.migration_error = :page_load
  config.active_record.verbose_query_logs = true
  config.assets.quiet = true
end
