require File.expand_path('../boot', __FILE__)

# Pick the frameworks you want:
require "active_model/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Rails41
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    config.to_prepare do
      DeviseController.respond_to :json
    end

    # for minitest-rails generators
    config.generators do |g|
      g.test_framework :mini_test, spec: true, fixture: false
    end

    # rails-lineman
    config.rails_lineman.lineman_project_location = Rails.application.secrets.lineman_project_location || ENV['LINEMAN_PROJECT_LOCATION']
    config.rails_lineman.lineman_assets = [:fonts, :css, :js]
    config.lineman_root = "#{Rails.application.secrets.ng_protocol}://#{Rails.application.secrets.ng_hostname}:#{Rails.application.secrets.ng_port}"
  end
end
