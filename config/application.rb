# frozen_string_literal: true

require_relative 'boot'
require 'rails/all'
Bundler.require(*Rails.groups)
module Ecommerce
  class Application < Rails::Application
    config.load_defaults 5.2
    config_file = Rails.application.config_for(:application)
    config_file&.each do |key, value|
      ENV[key] = value
    end
  end
end
