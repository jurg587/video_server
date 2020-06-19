require_relative 'boot'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module VideoServer
  class Application < Rails::Application
    config.load_defaults 6.0
    config.eager_load_paths << Rails.root.join('lib')
    config.autoload_paths << Rails.root.join('app')
    config.encoding = 'utf-8'
    config.time_zone = 'UTC'
    config.api_only = true
  end
end