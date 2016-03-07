require File.expand_path('../boot', __FILE__)

require 'rails'
# Pick the frameworks you want:
require 'active_model/railtie'
require 'active_job/railtie'
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'action_view/railtie'
require 'sprockets/railtie'

require 'elasticsearch/rails/instrumentation'
require 'elasticsearch/rails/lograge'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Yiliaohj
  class Application < Rails::Application
    config.autoload_paths << Rails.root.join('app/api')
    config.autoload_paths << Rails.root.join('lib')

    config.middleware.use Rack::Cors do
      allow do
        origins '*'
        resource '/api/*', headers: :any, methods: [:get, :post, :options, :put, :delete]
      end
    end

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.time_zone = 'Beijing'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    config.i18n.available_locales = [:en, :'zh-CN']
    config.i18n.default_locale = :"zh-CN"

    config.active_job.queue_adapter = :sidekiq

    config.lograge.enabled = true
    config.lograge.keep_original_rails_log = true
    config.lograge.logger = ActiveSupport::Logger.new "#{Rails.root}/log/lograge_#{Rails.env}.log"
  end
end
