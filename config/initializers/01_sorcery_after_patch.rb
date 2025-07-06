Rails.application.config.after_initialize do
  config = Rails.application.config.sorcery
  config.line.key = ENV["LINE_CHANNEL_ID"]
  config.line.secret = ENV["LINE_CHANNEL_SECRET"]
  config.line.callback_url = ENV["LINE_CALLBACK_URL"]
end
