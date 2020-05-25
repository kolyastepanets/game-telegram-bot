ActiveAdmin.register ApplicationText do
  actions :index, :show, :update, :edit

  permit_params :text

  form do |f|
    f.inputs :text
    f.inputs :key,
            as: :select,
            disabled: true,
            collection: ApplicationText::KEYS

    f.actions
  end
end
