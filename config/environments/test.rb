# frozen_string_literal: true

Rails.application.configure do
  config.cache_classes = false
  config.assets.compile = true
  config.eager_load = false
  config.public_file_server.enabled = true
  config.public_file_server.headers = {
    'Cache-Control' => "public, max-age=#{1.hour.to_i}"
  }
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = false
  config.action_dispatch.show_exceptions = true
  config.action_controller.allow_forgery_protection = false
  config.active_storage.service = :test
  config.action_mailer.perform_caching = false
  config.action_mailer.delivery_method = :test
  config.active_support.deprecation = :stderr
  config.after_initialize do
    ActiveMerchant::Billing::Base.mode = :test
    ::GATEWAY = ActiveMerchant::Billing::BogusGateway.new
  end
end
