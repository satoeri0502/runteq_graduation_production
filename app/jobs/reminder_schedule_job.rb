class ReminderScheduleJob < ApplicationJob
  queue_as :default

  def perform
    # Rakeタスクをジョブ内で安全に呼び出す準備
    Rake.application.init
    Rake.application.load_rakefile

    puts "📅 ReminderScheduleJob started at #{Time.current}"

    # lib/tasks/reminder.rakeの通知予約処理を実行
    # 通知スケジュール登録のRakeタスクを呼び出し
    Rake::Task["reminder:schedule"].reenable # <- 毎回実行できるように
    Rake::Task["reminder:schedule"].invoke
  end
end
