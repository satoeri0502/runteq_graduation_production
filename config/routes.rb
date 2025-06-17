Rails.application.routes.draw do
  get "password_resets/create"
  get "password_resets/edit"
  get "password_resets/update"
  # test用のページ
  # root "pages#index"

  # エントランスルート
  root 'homes#index'

  # LINEOAuth認証用ルート
  post 'oauth/callback' => 'oauths#callback'
  get 'oauth/callback' => 'oauths#callback'
  get 'oauth/:provider' => 'oauths#oauth', :as => :auth_at_provider

  # メールログイン用ルート
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'

  # 新規登録用ルート
  resources :users do
    collection do
      get  :setup_profile
      patch :complete_setup
      get  :email_prompt
      get  :email_register
      patch :complete_email
      get :registration_complete
    end
  end

  # おくすり用ルート
  resources :medicines

  # パスワードリセット用
  resources :password_resets, only: [:new, :create, :edit, :update]
  get 'password_resets/send_complete', to: 'password_resets#send_complete', as: :complete_password_resets   # リセット申請完了画面表示用
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
