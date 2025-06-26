class MedicinesController < ApplicationController

  # おくすり一覧画面
  def index
    @user = current_user
    @medicines = Medicine.all
  end
end
