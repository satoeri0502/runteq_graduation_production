class ReminderScheduler
  def self.call(user:)
    today = Date.current

    # ステップ1: 古いジョブの削除
    Sidekiq::ScheduledSet.new.each do |job|
      # ReminderNotificationJobかつ、そのユーザー向けのジョブのみ削除対象
      if job.klass == "ReminderNotificationJob" && job.args[0].to_i == user.id
        job.delete
        puts "🗑 古い通知ジョブを削除しました → #{job.args.inspect}"
      end
    end

    # ステップ2: 最新の情報から通知を登録
    user.medicines.includes(:dosetimings).each do |medicine|
      medicine.dosetimings.each do |dose|
        next unless user.line_user_id.present?

        # 通知時刻（過去なら翌日にスライド）
        reminder_time = dose.reminder_time.change(year: today.year, month: today.month, day: today.day)
        reminder_time += 1.day if reminder_time < Time.current

        # job_key = [user_id, medicine_id, dose_time, dose_timing, epoch秒]
        job_key = [user.id, medicine.id, dose.dose_time, dose.dose_timing, reminder_time.to_i]

        # 登録
        ReminderNotificationJob.set(wait_until: reminder_time).perform_later(*job_key)
        puts "📩 登録：#{user.name} さんに #{reminder_time} に通知予定 → #{job_key.inspect}"
      end
    end
  end
end
