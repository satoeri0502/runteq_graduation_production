# app/services/reminder_scheduler.rb
class ReminderScheduler
  def self.call
    today = Date.current

    Dosetiming.includes(:medicine).find_each do |dose|
      user = dose.medicine.user
      next unless user.line_user_id.present?

      reminder_time = dose.reminder_time.change(year: today.year, month: today.month, day: today.day)
      medicine_name = dose.medicine.name
      message = <<~MSG.strip
        💊 #{dose.dose_time} #{dose.dose_timing} のご連絡💊
        【#{medicine_name}】を飲む時間です。
        飲み忘れにご注意ください！
      MSG

      job_found = Sidekiq::ScheduledSet.new.any? do |job|
        job.klass == "ReminderNotificationJob" &&
          job.args == [ user.id, message ] &&
          job.at.to_i == reminder_time.to_i
      end

      unless job_found
        ReminderNotificationJob.set(wait_until: reminder_time).perform_later(user.id, message)
        puts "📩 通知予約：#{user.name} さんに #{reminder_time} に送信予定 → #{message}"
      else
        puts "⚠️ スキップ：#{user.name} さんの #{reminder_time} の通知は既にスケジュールされています"
      end
    end
  end
end
