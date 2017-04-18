# frozen_string_literal: true
require_relative 'boot'

require 'rails'
# Pick the frameworks you want:
require 'active_model/railtie'
require 'active_job/railtie'
require 'active_record/railtie'
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'action_view/railtie'
require 'action_cable/engine'
# require "sprockets/railtie"
require 'rails/test_unit/railtie'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module BangbangBackend
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Only loads a smaller set of middleware suitable for API only apps.
    # Middleware like session, flash, cookies can be added back manually.
    # Skip views, helpers and assets when generating a new resource.

    config.paperclip_defaults = {
      storage: :s3,
      s3_credentials: {
        bucket: Rails.application.secrets.s3_bucket,
        access_key_id: Rails.application.secrets.s3_key,
        secret_access_key: Rails.application.secrets.s3_secret,
        s3_region: 'us-east-1'
      }
    }

    config.api_only = true
    config.enable_dependency_loading = true
    config.autoload_paths << Rails.root.join('lib', 'user_act_strategies')
    # config.eager_load_paths << Rails.root.join('lib', 'user_act_strategies')
  end
end
