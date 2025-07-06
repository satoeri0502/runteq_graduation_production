Rails.application.config.after_initialize do
  line = Rails.application.config.sorcery.send(:line)
  line.client_id     = ENV["LINE_CHANNEL_ID"]
  line.client_secret = ENV["LINE_CHANNEL_SECRET"]
  line.callback_url  = ENV["LINE_CALLBACK_URL"]
  line.scope         = "profile"
  line.display       = "popup"
  line.user_info_mapping = { uid: "userId", name: "displayName" }
end
