require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Owl
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.time_zone = 'Tokyo'
    config.i18n.default_locale = :ja
    # config.i18n.default_locale = :jack_o_lantern

    config.to_prepare do
      
      #Devise::SessionsController.layout proc{ |controller| user_signed_in? ? "application" : "mailer" }
      #ApplicationController.layout proc{ |controller| user_signed_in? ? "application" : "login" }
      # Devise::RegistrationsController.layout "devise"
      # Devise::ConfirmationsController.layout "devise"
      # Devise::UnlocksController.layout "devise"
      # Devise::PasswordsController.layout "devise" 
    end

  end

end
