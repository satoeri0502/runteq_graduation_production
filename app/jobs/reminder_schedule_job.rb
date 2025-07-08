class ReminderScheduleJob < ApplicationJob
  queue_as :default

  def perform
    puts "📅 ReminderScheduleJob started at #{Time.current}"
    ReminderScheduler.call
  end
end
