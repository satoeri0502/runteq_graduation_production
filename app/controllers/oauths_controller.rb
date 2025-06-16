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
      Rails.logger.debug "Found user: #{@user.inspect}"
      redirect_to root_path, :notice => "Logged in from #{provider.titleize}!"
    else
      begin
        @user = create_from(provider)
        # Rails.logger.debug "Uid: #{@user.id}"
        # Rails.logger.debug "Uid: #{@user.inspect}"
        session[:user_id] = @user.id # 初期設定画面で使うため一時保存

        redirect_to setup_profile_users_path

        # reset_session # protect from session fixation attack
        # auto_login(@user)
        # redirect_to root_path, :notice => "Logged in from #{provider.titleize}!"
      rescue => e
        Rails.logger.error "Login failed: #{e.message}"
        Rails.logger.error e.backtrace.join("\n")
        redirect_to root_path, :alert => "Failed to login from #{provider.titleize}!"
      end
    end
  end

  # private

  # def auth_params
  #     params.permit(:code, :provider, :error, :state)
  # end
end
