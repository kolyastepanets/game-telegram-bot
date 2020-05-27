ActiveAdmin.register User do
  permit_params :nickname, :time_to_play

  show do
    attributes_table_for user do
      row :nickname
      row :time_to_play
      row :tg_id
      row :tg_first_name
      row :tg_last_name
      row :tg_username
      row :is_bot
      row :tg_language_code
      row :created_at
      row :updated_at
      row :has_blocked_bot

      table_for user.games do
        column :name
        column :platform
      end
    end
  end
end
