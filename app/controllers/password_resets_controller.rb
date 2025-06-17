class PasswordResetsController < ApplicationController
  skip_before_action :require_login

  def new; end

  def create
    @user = User.find_by(email: params[:email])
    @user&.deliver_reset_password_instructions!
    redirect_to complete_password_resets_path
  end

  def send_complete; end;

  def edit
    @token = params[:id]
    @user = User.load_from_reset_password_token(params[:id])
    not_authenticated if @user.blank?
  end

  def update
    @token = params[:id]
    @user = User.load_from_reset_password_token(params[:id])

    if @user.blank?
      not_authenticated
      return
    end

    Rails.logger.debug "pass: #{params[:user][:password]}"
    Rails.logger.debug "pass_c: #{params[:user][:password_confirmation]}"
    @user.password_confirmation = params[:user][:password_confirmation]
    if @user.change_password(params[:user][:password])
      redirect_to login_path
      flash[:success]= 'パスワードがリセットされました'
    else
      render action: 'edit'
    end
  end
end
