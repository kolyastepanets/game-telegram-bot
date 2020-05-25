class TelegramWebhooksController < Telegram::Bot::UpdatesController
  include Telegram::Bot::UpdatesController::MessageContext

  before_action :init_user

  def start!(*)
    text = "Выберите действие"
    begin
      respond_with(:message, text: text, reply_markup: {
        inline_keyboard: [
          [
            {text: 'Внести информацию', callback_data: 'add_user'},
            {text: 'Найти игрока', callback_data: 'find_user_to_play'},
          ]
        ],
      })
    rescue Telegram::Bot::Forbidden => e
      puts "it is sad"
      # user = User.find_by(uid: from[:id])
      # user.update(has_blocked: true)
    end
  end

  def callback_query(data)
    case data
    when 'find_user_to_play'
      find_user_to_play
    when 'add_user'
      choose_favourite_game
    when *game_ids
      save_game_to_user(data)
    when *choose_player
      find_random_user(data)
    when *ranges
      save_time_slot_to_user(data)
    when *ranges_replies
      respond_with(
        :message,
        text: "Выберите время",
        reply_markup: {
          inline_keyboard: [
            send(data).map do |time_slot|
              { text: time_slot[:text], callback_data: time_slot[:callback_data] }
            end
          ]
        }
      )
    else
      # return help
    end
  end

  def save_nickname!(nickname = nil, *)
    if nickname
      @user.update(nickname: nickname)
      save_time
    else
      save_context :save_nickname!
      respond_with(
        :message,
        text: "Ваш ник в игре?",
      )
    end
  end

  def save_time
    respond_with(
      :message,
      text: "Когда вы обычно играете?",
      reply_markup: {
        inline_keyboard: [
          ranges_first_reply.map do |time_slot|
            { text: time_slot[:text], callback_data: time_slot[:callback_data] }
          end
        ]
      }
    )
  end

  private

  def find_user_to_play
    respond_with(
      :message,
      text: "Ваша любимая игра?",
      reply_markup: {
        inline_keyboard: [
          Game.all.map do |game|
            { text: game.name, callback_data: "#{game.id} choose_player" }
          end
        ]
      }
    )
  end

  def find_random_user(data)
    game_id = data.split(" ")[0]
    user = User.joins(:games).where(games: { id: game_id} ).order(Arel.sql('RANDOM()')).first
    text = "Ничего не найдено"
    text = "Мой никнейм - #{user.nickname}. Я обычно играю: #{user.time_to_play}" if user
    respond_with(
      :message,
      text: text,
    )
  end

  def save_time_slot_to_user(slot)
    @user.update(time_to_play: slot)
    respond_with(
      :message,
      text: "Спасибо, данные сохранены! Начать сначала /start"
    )
  end

  def save_game_to_user(game_id)
    current_game = Game.find_by(id: game_id)
    if GameUser.where(game_id: current_game.id, user_id: @user.id).blank?
      GameUser.create(user_id: @user.id, game_id: current_game.id)
    end
    save_nickname!
  end

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

  def init_user
    @user ||= User.find_or_create_by(
      tg_id: from[:id],
      tg_first_name: from[:first_name],
      tg_last_name: from[:last_name],
      tg_username: from[:username],
      tg_language_code: from[:language_code],
      is_bot: from[:is_bot]
    )
  end

  def game_ids
    @game_ids ||= Game.pluck(:id).map(&:to_s)
  end

  def ranges_first_reply
    [
      { text: "00:00 - 12:00", callback_data: "first_half_day" },
      { text: "13:00 - 23:59", callback_data: "last_half_day" },
    ]
  end

  def first_half_day
    [
      { text: "00 - 04", callback_data: "00 - 04" },
      { text: "04 - 08", callback_data: "04 - 08" },
      { text: "08 - 12", callback_data: "08 - 12" },
    ]
  end

  def last_half_day
    [
      { text: "12 - 16", callback_data: "12 - 16" },
      { text: "16 - 20", callback_data: "16 - 20" },
      { text: "20 - 00", callback_data: "20 - 00" },
    ]
  end

  def ranges
    [
      "00 - 04",
      "04 - 08",
      "08 - 12",
      "12 - 16",
      "16 - 20",
      "20 - 00"
    ]
  end

  def ranges_replies
    [
      "first_half_day", "last_half_day", "ranges_second_reply", "ranges_third_reply",
      "ranges_fourth_reply", "ranges_fifth_reply"
    ]
  end

  def choose_player
    game_ids.map { |game_id| "#{game_id} choose_player" }
  end
end
