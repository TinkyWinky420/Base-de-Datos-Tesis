require_relative "boot"

require "rails/all"

Bundler.require(*Rails.groups)

module Tesis
  class Application < Rails::Application
    config.load_defaults 8.1

    config.autoload_lib(ignore: %w[assets tasks])

    config.i18n.default_locale = :es

    config.time_zone = "Mexico City"
    config.active_record.default_timezone = :local
  end
end