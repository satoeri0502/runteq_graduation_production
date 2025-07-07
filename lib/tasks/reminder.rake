namespace :reminder do  # rake reminder:scheduleで呼び出せる
  desc "当日のおくすり通知を予約"
  task schedule: :environment do
    ReminderScheduler.call
  end
end
