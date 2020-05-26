class AddHasBlockedBotToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :has_blocked_bot, :boolean, default: false
  end
end
