class CreateApplicationTexts < ActiveRecord::Migration[6.0]
  def change
    create_table :application_texts do |t|
      t.string :text
      t.string :key

      t.timestamps
    end

    ApplicationText.create(text: "Выберите действие",        key: 'choose_action')
    ApplicationText.create(text: "Внести информацию",        key: 'enter_info')
    ApplicationText.create(text: "Найти игрока",             key: 'find_user')
    ApplicationText.create(text: "Выберите время",           key: 'choose_time')
    ApplicationText.create(text: "Ваш ник в игре?",          key: 'ask_for_nickname')
    ApplicationText.create(text: "Повторить поиск",          key: 'retry_search')
    ApplicationText.create(text: "Ваша любимая игра?",       key: 'question_favourite_game')
    ApplicationText.create(text: "Выберите платформу",       key: 'choose_platform')
    ApplicationText.create(text: "Ничего не найдено",        key: 'nothing_found')
    ApplicationText.create(text: "Когда вы обычно играете?", key: 'ask_for_time_to_play')
    ApplicationText.create(text: "Мой никнейм - ",           key: 'my_nickname')
    ApplicationText.create(text: ". Я обычно играю: ",       key: 'i_usually_play')
    ApplicationText.create(text: "На главную",               key: 'start_again')
    ApplicationText.create(text: "Игр больше нет",           key: 'no_more_games')
    ApplicationText.create(text: "4",                        key: 'show_games_at_a_time')
    ApplicationText.create(text: "Спасибо, данные сохранены! Начать сначала /start", key: 'data_saved')
  end
end
