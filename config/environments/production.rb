Rails.application.configure do
  config.enable_reloading = false
  config.eager_load = true
  config.consider_all_requests_local = false
  config.action_controller.perform_caching = true
  config.assets.compile = false
  config.force_ssl = true

  config.log_level = ENV.fetch("RAILS_LOG_LEVEL", "info").to_sym
  config.log_tags = [:request_id]
  config.logger = ActiveSupport::Logger.new(STDOUT).tap do |logger|
    logger.formatter = ::Logger::Formatter.new
  end.then do |logger|
    ActiveSupport::TaggedLogging.new(logger)
  end

  config.action_mailer.raise_delivery_errors = false
  config.action_mailer.perform_caching = false
  config.action_mailer.default_url_options = { host: "yourdomain.com" }
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    address:              ENV.fetch('MAIL_ADDRESS'),
    port:                 ENV.fetch('MAIL_PORT', 587),
    domain:               ENV.fetch('MAIL_DOMAIN', 'yourdomain.com'),
    user_name:            ENV.fetch('MAIL_USERNAME'),
    password:             ENV.fetch('MAIL_PASSWORD'),
    authentication:       ENV.fetch('MAIL_AUTHENTICATION', 'plain'),
    enable_starttls_auto: ENV.fetch('MAIL_ENABLE_STARTTLS_AUTO', 'true') == 'true'
  }

  config.active_record.dump_schema_after_migration = false
  config.i18n.fallbacks = true
  config.active_support.report_deprecations = false
  config.active_record.verbose_query_logs = false
end
