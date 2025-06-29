class UserSessionsController < ApplicationController
  skip_before_action :require_login, only: %i[new create]

  # ログイン画面表示
  def new; end

  # ログイン処理
  def create
    @user = login(params[:email], params[:password])

    if @user
      redirect_to medicines_path success: "ログインに成功しました"
    else
      flash.now[:danger] = "ログインに失敗しました"
      render :new, status: :unprocessable_entity
    end
  end

  # ログアウト処理
  def destroy
    logout
    redirect_to root_path, status: :see_other, success: "ログアウトしました"
  end
end
