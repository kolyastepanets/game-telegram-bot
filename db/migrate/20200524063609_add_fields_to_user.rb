class AddFieldsToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :tg_id, :integer
    add_column :users, :tg_first_name, :string
    add_column :users, :tg_last_name, :string
    add_column :users, :tg_username, :string
    add_column :users, :is_bot, :boolean
    add_column :users, :tg_language_code, :string
  end
end
