class ApplicationJob < ActiveJob::Base
  queue_as :default

  def perform(name = "テストユーザー")
    Rails.logger.info "✅ Sidekiqテスト：#{name}さん、こんにちは！"
  end
end
