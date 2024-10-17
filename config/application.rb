require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Myapp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.2

    # Please, add to the `ignore` list any other `lib` subdirectories that do
    # not contain `.rb` files, or that should not be reloaded or eager loaded.
    # Common ones are `templates`, `generators`, or `middleware`, for example.
    config.autoload_lib(ignore: %w[assets tasks])

    # Set the default locale to Japanese
    config.i18n.default_locale = :ja

    # Optimize asset precompilation
    config.assets.initialize_on_precompile = false

    # Add paths for asset loading
    config.assets.paths << Rails.root.join('config')

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    # Configure generators
    config.generators do |g|
      g.skip_routes true # Don't generate routes automatically
      g.helper false # Don't generate helper files automatically
      g.test_framework nil # Don't use a test framework
    end
  end
end
