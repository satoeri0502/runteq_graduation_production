# user_idを受け取って対象ユーザーのLINEへ指定メッセージを送信するジョブ
class ReminderNotificationJob < ApplicationJob
  # 実行するキューの種類（=Sidekiqが使う変数）をDefaultに指定
  queue_as :default

  def perform(user_id, message)
    # ユーザー取得
    user = User.find_by(id: user_id)

    # もしLINE通知に必要なline_user_idがなかったらスキップ
    return unless user&.line_user_id.present?

    # LINE通知処理(app/services/line_notifier.rbを実行)
    LineNotifier.send_message(to: user.line_user_id, message: message)
  end
end
