class UsersController < ApplicationController
  skip_before_action :require_login

  # 新規登録：
  def setup_profile
    @user = User.find_by(id: session[:user_id])
    Rails.logger.debug "setup_User: #{@user.inspect}"
    redirect_to root_path, alert: "ユーザー情報が見つかりません" unless @user
  end

  def complete_setup
    @user = User.find_by(id: session[:user_id])
    Rails.logger.debug "params1: #{params[:user][:age]}"
    Rails.logger.debug "params2: #{params[:user][:gender]}"
    if @user.update(setup_params)
      Rails.logger.debug "comp_User: #{@user.inspect}"
      redirect_to email_prompt_users_path
    else
      Rails.logger.debug @user.errors.full_messages
    end
  end

  def email_prompt; end;

  def email_register
    @user = User.find_by(id: session[:user_id])
  end

  def complete_email
    @user = User.find_by(id: session[:user_id])
    Rails.logger.debug "email: #{params[:user][:email]}"
    Rails.logger.debug "password: #{params[:user][:password]}"
    Rails.logger.debug "password_C: #{params[:user][:password_confirmation]}"
    if @user.update(email_params)
      Rails.logger.debug "compmail_User: #{@user.inspect}"
      redirect_to registration_complete_users_path
    else
      Rails.logger.debug "▼▼▼ update失敗 ▼▼▼"
      Rails.logger.debug @user.errors.full_messages
      render :email_register, status: :unprocessable_entity
    end
  end

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
