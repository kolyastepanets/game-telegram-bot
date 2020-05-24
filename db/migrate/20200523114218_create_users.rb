class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :nickname
      t.string :time_to_play
      t.integer :tg_id
      t.string :tg_first_name
      t.string :tg_last_name
      t.string :tg_username
      t.boolean :is_bot
      t.string :tg_language_code

      t.timestamps
    end

    add_index :users, :nickname, unique: true
  end
end
