class ChangeForeighnKeysToInteger < ActiveRecord::Migration[6.0]
  def change
    change_column :game_users, :game_id, "integer USING CAST(game_id AS integer)"
    change_column :game_users, :user_id, "integer USING CAST(user_id AS integer)"
  end
end
