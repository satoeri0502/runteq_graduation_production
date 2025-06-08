class OauthsController < ApplicationController
  
  # ユーザーをプロバイダーに送る
  def oauth
    login_at(params[:provider])
  end

  # 認証が完了するとコールバックURLに戻る
  def callback
    provider = params[:provider]
    Rails.logger.debug "Provider: #{provider.inspect}"
    Rails.logger.debug "Access token: #{access_token(provider).inspect}"
    if @user = login_from(provider)
      Rails.logger.debug "Found user: #{@user.inspect}"
      redirect_to root_path, :notice => "Logged in from #{provider.titleize}!"
    else
      begin
        Rails.logger.debug "User not found. Trying to create new user."
        @user = create_from(provider)
        Rails.logger.debug "Created user: #{@user.inspect}"
        # NOTE: this is the place to add '@user.activate!' if you are using user_activation submodule

        reset_session # protect from session fixation attack
        auto_login(@user)
        redirect_to root_path, :notice => "Logged in from #{provider.titleize}!"
      rescue => e
        Rails.logger.error "Login failed: #{e.message}"
        redirect_to root_path, :alert => "Failed to login from #{provider.titleize}!"
      end
    end
  end

  # private

  # def auth_params
  #     params.permit(:code, :provider, :error, :state)
  # end
end
