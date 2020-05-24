Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  telegram_webhook TelegramWebhooksController
end
