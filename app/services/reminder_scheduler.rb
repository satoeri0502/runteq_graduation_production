class ReminderScheduler
  # 1つの薬に対するジョブ削除
  def self.delete_jobs_for(user:, medicine:)
    deleted = 0
    scheduled_jobs = Sidekiq::ScheduledSet.new

    if scheduled_jobs.size.zero?
      puts "⚠️ ScheduledSet は空です"
    end

    scheduled_jobs.each do |job|
      puts "👀 job.klass: #{job.klass} / args: #{job.args.inspect}"

      # class名が完全一致しない可能性を考慮して部分一致にしてみる
      next unless job.klass.to_s.include?("ReminderNotificationJob")

      job_user_id     = job.args[0].to_s
      job_medicine_id = job.args[1].to_s

      next unless job_user_id == user.id.to_s
      next unless job_medicine_id == medicine.id.to_s

      job.delete
      deleted += 1
      puts "🗑 通知ジョブ削除 → #{job.args.inspect}"
    end

    puts "✅ #{medicine.name} の通知ジョブを #{deleted} 件削除しました"
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
