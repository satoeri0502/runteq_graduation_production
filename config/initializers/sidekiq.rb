require "sidekiq/cron/job"

Sidekiq::Cron::Job.load_from_hash!(
  reminder_schedule_job: {
    cron: "0 3 * * *", # 毎朝3時に実行（日本時間）
    class: "ReminderScheduleJob"
  }
)
