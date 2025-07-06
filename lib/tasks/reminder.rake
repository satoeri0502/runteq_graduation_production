namespace :reminder do  # rake reminder:scheduleで呼び出せる
  desc "当日のおくすり通知を予約"
  task schedule: :environment do
    today = Date.current

    # おくすりの服用情報＋薬のユーザー情報を全取得
    Dosetiming.includes(:medicine).find_each do |dose|
      # 薬の持ち主を取得(ユーザーがline_user_idを持っていない場合は次のデータにスキップ)
      user = dose.medicine.user
      next unless user.line_user_id.present?

      # reminder_timeは年月日時分秒になっているので必要部分だけに成形
      reminder_time = dose.reminder_time.change(year: today.year, month: today.month, day: today.day)
      medicine_name = dose.medicine.name
      message = <<~MSG.strip
        💊 #{dose.dose_time} #{dose.dose_timing} のご連絡💊
        【#{medicine_name}】を飲む時間です。
        飲み忘れにご注意ください！
      MSG

      # app/jobs/reminder_notification_job.rb
      # 上記クラスを実行する時間、送信対象、送信内容をRedisに保存
      # perform_later：ジョブをキューに入れる（後で実行）
      ReminderNotificationJob.set(wait_until: reminder_time).perform_later(user.id, message)

      puts "📩 通知予約：#{user.name} さんに #{reminder_time} に送信予定 → #{message}"
    end
  end
end
