Rails.application.routes.draw do
  # ゲーム関連
  get "games/cashier" => "games#cashier"
  get "games/claim" => "games#claim"
  get "games/order" => "games#order"
  get "games/replenishing" => "games#replenishing"
  get "games/game_top" => "games#game_top"
  post "games/save_cashier_score", to: "games#save_cashier_score"
  post "games/save_claim_score", to: "games#save_claim_score"
  post "games/save_order_score", to: "games#save_order_score"
  post "games/save_replenishing_score", to: "games#save_replenishing_score"

  # いいね関連
  post "likes/:post_id/create", to: "likes#create", as: "create_like"
  delete "likes/:post_id/destroy", to: "likes#destroy", as: "destroy_like"
  get "users/:id/likes", to: "users#likes", as: "user_likes"

  # ホーム関連
  root "home#top"
  get "about" => "home#about"
  get "how_to_play" => "home#how_to_play"

  # ユーザー関連
  resources :users, except: [:destroy] do
    collection do
      get :login
      post :login_form, path: "login"
      post :logout
    end
  end

  # 投稿関連
  get "posts/index" => "posts#index"
  get "posts/new" => "posts#new"
  post "posts/create" => "posts#create"
  get "posts/:id" => "posts#show"
  get "posts/:id/edit" => "posts#edit"
  patch "posts/:id" => "posts#update"
  delete "posts/:id" => "posts#destroy"

  get "users/:id/like" => "users#showlike"

end
