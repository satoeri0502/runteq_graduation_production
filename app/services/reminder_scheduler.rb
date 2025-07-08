class ReminderScheduler
  # 1つの薬に対するジョブ削除
  def self.delete_jobs_for(user:, medicine:)
    Sidekiq::ScheduledSet.new.each do |job|
      if job.klass == "ReminderNotificationJob" &&
          job.args[0].to_i == user.id &&
          job.args[1].to_i == medicine.id
        job.delete
        Rails.logger.info "🗑 削除：#{user.name} の #{medicine.name} 通知ジョブ → #{job.args.inspect}"
      end
    end
  end

  # 特定ユーザーの全お薬ジョブを再登録
  def self.call(user:)
    today = Date.current

    user.medicines.includes(:dosetimings).each do |medicine|
      # 古いジョブを削除
      delete_jobs_for(user: user, medicine: medicine)

      medicine.dosetimings.each do |dose|
        next unless user.line_user_id.present?

        # 通知時刻（過去なら翌日に）
        reminder_time = dose.reminder_time.change(year: today.year, month: today.month, day: today.day)
        reminder_time += 1.day if reminder_time < Time.current

        job_args = [user.id, medicine.id, dose.dose_time, dose.dose_timing, reminder_time.to_i]
        ReminderNotificationJob.set(wait_until: reminder_time).perform_later(*job_args)
        Rails.logger.info "📩 登録：#{user.name} さんに #{reminder_time} 通知予定 → #{job_args.inspect}"
      end
    end
  end

  # 全ユーザー分を対象に再スケジュール（朝3時の定期バッチ）
  def self.call_all
    User.includes(medicines: :dosetimings).find_each do |user|
      next unless user.line_user_id.present?
      call(user: user)
    end
  end
end
