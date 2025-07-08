namespace :reminder do
  desc "当日のおくすり通知を全ユーザー分まとめて登録"
  task schedule: :environment do
    ReminderScheduler.call_all
  end
end
