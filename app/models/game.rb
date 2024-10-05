class GamesController < ApplicationController
  def save_cashier_score
    # ログイン中のユーザーに紐づけたscoreを保存
    score = Score.find_or_initialize_by(user_id: current_user.id)
    score.cashier_score = params[:cashier_score]
    
    if score.save
      # 保存が成功した場合の処理
    else
      # 保存が失敗した場合の処理
    end
  end

  def save_claim_score
    # ログイン中のユーザーに紐づけたscoreを保存
    score = Score.find_or_initialize_by(user_id: current_user.id)
    score.claim_score = params[:claim_score]
    
    if score.save
      # 保存が成功した場合の処理
    else
      # 保存が失敗した場合の処理
    end
  end


  def save_order_score
    # ログイン中のユーザーに紐づけたscoreを保存
    score = Score.find_or_initialize_by(user_id: current_user.id)
    score.order_score = params[:order_score]
    
    if score.save
      # 保存が成功した場合の処理
    else
      # 保存が失敗した場合の処理
    end
  end


  def save_replenishing_score
    # ログイン中のユーザーに紐づけたscoreを保存
    score = Score.find_or_initialize_by(user_id: current_user.id)
    score.replenishing_score = params[:replenishing_score]
    
    if score.save
      # 保存が成功した場合の処理
    else
      # 保存が失敗した場合の処理
    end
  end





end
 