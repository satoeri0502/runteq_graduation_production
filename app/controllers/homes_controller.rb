class HomesController < ApplicationController
  skip_before_action :require_login

  # アプリエントランス画面表示
  def index; end;
end
