class OauthsController < ApplicationController
  skip_before_action :require_login

  # ユーザーをプロバイダーに送る
  def oauth
    login_at(params[:provider])
  end

  # 認証が完了するとコールバックURLに戻る
  def callback
    provider = params[:provider]

    if @user = login_from(provider)
      # ログイン
      redirect_to medicines_path, :success => "#{provider.titleize}ログインに成功しました！"
    else
      # 会員登録
      begin
        @user = create_from(provider)
        session[:user_id] = @user.id # 初期設定画面で使うため一時保存

        redirect_to setup_profile_users_path  # ユーザ情報入力画面へ遷移
      rescue => e
        Rails.logger.error "Login failed: #{e.message}"
        Rails.logger.error e.backtrace.join("\n")
        redirect_to root_path, :alert => "#{provider.titleize}登録に失敗しました"
      end
    end
  end

  # private

  # def auth_params
  #     params.permit(:code, :provider, :error, :state)
  # end
end
