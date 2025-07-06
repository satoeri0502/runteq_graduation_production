class PasswordResetsController < ApplicationController
  skip_before_action :require_login

  # パスワードリセット画面
  def new; end

  # メールアドレスへリセットメール送信
  def create
    @user = User.find_by(email: params[:email])
    @user&.deliver_reset_password_instructions!
    redirect_to complete_password_resets_path
  end

  # メール送信完了メッセージ画面
  def send_complete; end

  # 新パスワード入力画面
  def edit
    @token = params[:id]
    @user = User.load_from_reset_password_token(params[:id])
    not_authenticated if @user.blank?
  end

  # 新パスワード登録
  def update
    @token = params[:id]
    @user = User.load_from_reset_password_token(params[:id])

    if @user.blank?
      not_authenticated
      return
    end

    @user.password_confirmation = params[:user][:password_confirmation]
    if @user.change_password(params[:user][:password])
      redirect_to login_path
      flash[:success]= "パスワードがリセットされました"
    else
      render action: "edit"
    end
  end
end
