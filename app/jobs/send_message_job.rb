require 'telegram/bot'

class SendMessageJob < ApplicationJob
  queue_as :default

  def perform(tg_user_id:, text:)
    bot = Telegram::Bot::Client.new(ENV['TELEGRAM_BOT_TOKEN'])
    bot.send_message(chat_id: tg_user_id, text: text)
  rescue Telegram::Bot::Forbidden => e
    user = User.find_by(tg_id: tg_user_id)
    user.update(has_blocked_bot: true)
  end
end
