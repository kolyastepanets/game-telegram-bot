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

  def first_half_day
    [
      { text: "0 - 1", callback_data: "0 - 1" },
      { text: "1 - 2", callback_data: "1 - 2" },
      { text: "2 - 3", callback_data: "2 - 3" },
      { text: "3 - 4", callback_data: "3 - 4" },
      { text: "еще", callback_data: "ranges_fourth_reply" }
    ]
  end

  def ranges_fourth_reply
    [
      { text: "4 - 5", callback_data: "4 - 5" },
      { text: "5 - 6", callback_data: "5 - 6" },
      { text: "6 - 7", callback_data: "6 - 7" },
      { text: "7 - 8", callback_data: "7 - 8" },
      { text: "еще", callback_data: "ranges_fifth_reply" }
    ]
  end

  def ranges_fifth_reply
    [
      { text: "8 - 9", callback_data: "8 - 9" },
      { text: "9 - 10", callback_data: "9 - 10" },
      { text: "10 - 11", callback_data: "10 - 11" },
      { text: "11 - 12", callback_data: "11 - 12" },
    ]
  end

  def ranges_first_reply
    [
      { text: "00:00 - 12:00", callback_data: "first_half_day" },
      { text: "13:00 - 23:59", callback_data: "last_half_day" },
    ]
  end

  def last_half_day
    [
      { text: "12 - 13", callback_data: "12 - 13" },
      { text: "13 - 14", callback_data: "13 - 14" },
      { text: "14 - 15", callback_data: "14 - 15" },
      { text: "15 - 16", callback_data: "15 - 16" },
      { text: "еще", callback_data: "ranges_second_reply" }
    ]
  end

  def ranges_second_reply
    [
      { text: "16 - 17", callback_data: "16 - 17" },
      { text: "17 - 18", callback_data: "17 - 18" },
      { text: "18 - 19", callback_data: "18 - 19" },
      { text: "19 - 20", callback_data: "19 - 20" },
      { text: "еще", callback_data: "ranges_third_reply" }
    ]
  end

  def ranges_third_reply
    [
      { text: "20 - 21", callback_data: "20 - 21" },
      { text: "21 - 22", callback_data: "21 - 22" },
      { text: "22 - 23", callback_data: "22 - 23" },
      { text: "23 - 00", callback_data: "23 - 00" },
    ]
  end

  def ranges
    @ranges ||= begin
      ra = (00..23).to_a
      ranges = []
      ra.map.with_index do |num, index|
        if ra.last == num
          ranges << "23 - 00"
        else
          ranges << "#{num} - #{ra[index + 1]}"
        end
      end
      ranges
    end
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
