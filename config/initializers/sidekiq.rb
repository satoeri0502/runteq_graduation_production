require "sidekiq/cron/job"
require "sidekiq/web"

# 本番環境のみBasic認証をかける
if Rails.env.production?
  Sidekiq::Web.use(Rack::Auth::Basic) do |user, password|
    [ user, password ] == [ ENV["SIDEKIQ_USER"], ENV["SIDEKIQ_PASSWORD"] ]
  end
end

# RedisのURLを環境変数から取得（なければローカル用）
redis_url = ENV.fetch("REDIS_URL") { "redis://localhost:6379/0" }

Sidekiq.configure_server do |config|
  config.redis = { url: redis_url }

  # Cronジョブはサーバー側でのみ設定
  Sidekiq::Cron::Job.load_from_hash!(
    reminder_schedule_job: {
      cron: "0 3 * * *", # 毎朝3時に実行（日本時間）Renderは UTCで動いているので-9時間
      class: "ReminderScheduleJob"
    }
  )
end

Sidekiq.configure_client do |config|
  config.redis = { url: redis_url }
end
