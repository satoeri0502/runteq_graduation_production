class ReminderScheduleJob < ApplicationJob
  queue_as :default

  def perform
    # Rakeタスクをジョブ内で安全に呼び出す準備
    Rake.application.init
    Rake.application.load_rakefile

    # lib/tasks/reminder.rakeの通知予約処理を実行
    task = Rake::Task["reminder:schedule"]
    task.reenable  # ← 毎回ちゃんと動くように
    task.invoke
  end
end
