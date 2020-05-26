require 'sidekiq/web'

Sidekiq::Web.use Rack::Auth::Basic do |username, password|
  ActiveSupport::SecurityUtils.secure_compare(
    ::Digest::SHA256.hexdigest(username),
    ::Digest::SHA256.hexdigest(ENV.fetch('ADMIN_NAME'))
  ) & ActiveSupport::SecurityUtils.secure_compare(
    ::Digest::SHA256.hexdigest(password),
    ::Digest::SHA256.hexdigest(ENV.fetch('ADMIN_PASSWORD'))
  )
end

Rails.application.routes.draw do
  mount Sidekiq::Web, at: '/sidekiq'
  ActiveAdmin.routes(self)
  telegram_webhook TelegramWebhooksController
end
