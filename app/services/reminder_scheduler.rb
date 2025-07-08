# app/services/reminder_scheduler.rb
class ReminderScheduler
  def self.call(user:)
    today = Date.current

    # 対象ユーザーのmedicineに関連するdosetimingを取得
    user.medicines.includes(:dosetimings).each do |medicine|
      medicine.dosetimings.each do |dose|
        next unless user.line_user_id.present?

        # 通知時刻を作成し、過去なら翌日にスライド
        reminder_time = dose.reminder_time.change(year: today.year, month: today.month, day: today.day)
        reminder_time += 1.day if reminder_time < Time.current
        
        # 一意なキーで判定
        job_key = [
          user.id,
          medicine.id,
          dose.dose_time,
          dose.dose_timing,
          reminder_time.to_i
        ]

        job_found = Sidekiq::ScheduledSet.new.any? do |job|
          job.klass == "ReminderNotificationJob" &&
            job.args.map(&:to_s) == job_key.map(&:to_s) &&
            job.at.to_i == reminder_time.to_i
        end

        unless job_found
          ReminderNotificationJob.set(wait_until: reminder_time).perform_later(*job_key)
          puts "📩 通知予約：#{user.name} さんに #{reminder_time} に送信予定 → #{job_key.inspect}"
        else
          puts "⚠️ スキップ：#{user.name} さんの #{reminder_time} の通知は既にスケジュールされています"
        end
      end
    end
  end
end
