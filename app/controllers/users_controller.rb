class UsersController < ApplicationController
  skip_before_action :require_login

  # 新規登録：メアド、性別登録画面
  def setup_profile
    @user = User.find_by(id: session[:user_id])
    redirect_to root_path, alert: "ユーザー情報が見つかりません" unless @user
  end

  # 新規登録：メアド、性別登録処理
  def complete_setup
    @user = User.find_by(id: session[:user_id])
    if @user.update(setup_params)
      redirect_to email_prompt_users_path   # メール登録推奨画面へ遷移
    else
      Rails.logger.debug "▼▼▼ メアド・性別登録失敗 ▼▼▼"
      Rails.logger.debug @user.errors.full_messages
      render :setup_profile, status: :unprocessable_entity
    end
  end

  # メール登録推奨画面
  def email_prompt; end;

  # メール登録画面
  def email_register
    @user = User.find_by(id: session[:user_id])
  end

  # メール登録処理
  def complete_email
    @user = User.find_by(id: session[:user_id])
    if @user.update(email_params)
      redirect_to registration_complete_users_path
    else
      Rails.logger.debug "▼▼▼ メール登録失敗 ▼▼▼"
      Rails.logger.debug @user.errors.full_messages
      render :email_register, status: :unprocessable_entity
    end
  end

  # ユーザ情報登録完了画面
  def registration_complete
    @user = User.find_by(id: session[:user_id])
    auto_login(@user)
  end

  private

  def setup_params
    params.require(:user).permit(:gender, :age)
  end

  def email_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
