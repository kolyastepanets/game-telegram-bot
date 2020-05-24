class TelegramWebhooksController < Telegram::Bot::UpdatesController
  include Telegram::Bot::UpdatesController::MessageContext

  def start!(*)
    # binding.pry
    text = "Выберите действие"
    begin
      respond_with(:message, text: text, reply_markup: {
        inline_keyboard: [
          [
            {text: 'Внести информацию', callback_data: 'add_user'},
            {text: 'Найти игрока', callback_data: 'find_user'},
          ]
        ],
      })
    rescue Telegram::Bot::Forbidden => e
      puts "it is sad"
      # user = User.find_by(uid: from[:id])
      # user.update(has_blocked: true)
    end
  end

  # def help!(*)
  #   respond_with :message, text: t('help')
  # end

  # def message(*)
  #   respond_with :message, text: t('help')
  # end

  def callback_query(data)
    case data
    when 'find_user'
      # @user.update(language: 'ru')
      find_user
    when 'add_user'
      # @user.update(language: 'en')
      add_user
      choose_favourite_game
    when *game_ids
      save_game_to_user
    else
      # return help
    end
  end

  private

  def choose_favourite_game
    respond_with(
      :message,
      text: "Ваша любимая игра?",
      reply_markup: {
        inline_keyboard: [
          Game.all.map do |game|
            { text: game.name, callback_data: game.id }
          end
        ]
      }
    )

  end

  def add_user
    # binding.pry
    # user = User.find_by(uid: from[:id])
  end

  def find_user
    respond_with(
      :message,
      reply_markup: {
        inline_keyboard: [
          Game.all.map do |game|
            {text: game.name, callback_data: 'get_video'}
          end
        ]
      }
    )
  end

  def game_ids
    @game_ids ||= Game.pluck(:id)
  end
end
