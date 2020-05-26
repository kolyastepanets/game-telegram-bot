ActiveAdmin.register Message do
  actions :index, :new, :create

  permit_params :text

  form do |f|
    f.inputs do
      f.input :text, hint: 'Сообщение асинхронно будет отправлено всем пользователям бота'
    end

    f.actions
  end


  controller do
    def create
      tg_user_ids = User.pluck(:tg_id).compact
      Message.create(text: params["message"]["text"])
      tg_user_ids.each do |tg_user_id|
        SendMessageJob.perform_later(tg_user_id: tg_user_id, text: params["message"]["text"])
      end

      redirect_to admin_messages_path, notice: "Сообщения отправляются"
    end
  end
end
