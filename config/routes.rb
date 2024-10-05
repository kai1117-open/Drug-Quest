Rails.application.routes.draw do

  get "games/cashier" => "games#cashier"
  get "games/claim" => "games#claim"
  get "games/order" => "games#order"
  get "games/replenishing" => "games#replenishing"
  get "games/game_top" => "games#game_top"


  post 'likes/:post_id/create', to: 'likes#create', as: 'create_like'

  # いいね削除のルーティング
  delete 'likes/:post_id/destroy', to: 'likes#destroy', as: 'destroy_like'

  get 'users/:id/likes', to: 'users#likes', as: 'user_likes'


  

  # ホーム関連
  get "/" => "home#top"
  get "home/top" => "home#top"
  get "about" => "home#about"
  get "how_to_play" => "home#how_to_play"


  # ユーザー関連
  get "users/new" => "users#new"
  post "users/create" => "users#create"
  get "users/login" => "users#login"
  post "users/login" => "users#login_form"
  get "users/index" => "users#index"

  get "users/:id" => "users#show"

 

  get "users/:id/like" => "users#showlike"
  get "users/:id/like" =>"scores#show"

  get "users/:id/edit" => "users#edit"
  post "users/:id/update" => "users#update"
  post "users/logout" => "users#logout"
  

  # 投稿関連
  get "posts/index" => "posts#index"
  get "posts/new" => "posts#new"
  post "posts/create" => "posts#create"
  get "posts/:id" => "posts#show"
  get "posts/:id/edit" => "posts#edit"
  patch "posts/:id" => "posts#update"
  delete "posts/:id" => "posts#destroy"


  post '/games/save_cashier_score', to: 'games#save_cashier_score'
  post '/games/save_claim_score', to: 'games#save_claim_score'
  post '/games/save_order_score', to: 'games#save_order_score'
  post '/games/save_replenishing_score', to: 'games#save_replenishing_score'
end
 