class GamesController < ApplicationController

  def new
  end

  def create
  end



  def save_cashier_score
    # ログイン中のユーザーに紐づけたscoreを保存
    score = Score.find_or_initialize_by(user_id: @current_user.id)
    score.cashier_score = params[:cashier_score]
    
    if score.save
      flash[:notice] = "スコアが保存されました"
      redirect_to ("/games/game_top") # 保存後にリダイレクト先を設定
    else
      flash[:alert] = "スコアの保存に失敗しました"
      render("/games/game_top") # エラー時の表示先を設定
    end
  end





  def save_claim_score
    # ログイン中のユーザーに紐づけたscoreを保存
    score = Score.find_or_initialize_by(user_id: @current_user.id)
    score.claim_score = params[:claim_score]
    
    if score.save
      flash[:notice] = "スコアが保存されました"
      redirect_to ("/games/game_top") # 保存後にリダイレクト先を設定
    else
      flash[:alert] = "スコアの保存に失敗しました"
      render("/games/game_top") # エラー時の表示先を設定
    end
  end




  def save_order_score
    # ログイン中のユーザーに紐づけたscoreを保存
    score = Score.find_or_initialize_by(user_id: @current_user.id)
    score.order_score = params[:order_score]
    
    if score.save
      flash[:notice] = "スコアが保存されました"
      redirect_to ("/games/game_top") # 保存後にリダイレクト先を設定
    else
      flash[:alert] = "スコアの保存に失敗しました"
      render("/games/game_top") # エラー時の表示先を設定
    end
  end



  def save_replenishing_score
    # ログイン中のユーザーに紐づけたscoreを保存
    score = Score.find_or_initialize_by(user_id: @current_user.id)
    score.replenishing_score = params[:replenishing_score]
    
    if score.save
      flash[:notice] = "スコアが保存されました"
      redirect_to ("/games/game_top") # 保存後にリダイレクト先を設定
    else
      flash[:alert] = "スコアの保存に失敗しました"
      render("/games/game_top") # エラー時の表示先を設定
    end
  end




end
