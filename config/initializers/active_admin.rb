ActiveAdmin.setup do |config|
  config.site_title = "Game Bot"
  config.logout_link_path = :destroy_admin_user_session_path
  config.batch_actions = true
  config.filter_attributes = [:encrypted_password, :password, :password_confirmation]
  config.localize_format = :long
  config.comments = false
  config.root_to = 'games#index'
  config.before_action do
    authenticate_or_request_with_http_basic do |name, password|
      name == "frodo" && password == "thering"
    end
  end
end
