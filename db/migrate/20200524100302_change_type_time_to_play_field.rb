class ChangeTypeTimeToPlayField < ActiveRecord::Migration[6.0]
  def change
    change_column :users, :time_to_play, :string
  end
end
