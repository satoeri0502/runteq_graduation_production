class ReminderScheduleJob < ApplicationJob
  queue_as :default

  def perform
    # Rakeタスクをジョブ内で安全に呼び出す準備
    Rake.application.init
    Rake.application.load_rakefile

    puts "📅 ReminderScheduleJob started at #{Time.current}"
    ReminderScheduler.call
  end
end
