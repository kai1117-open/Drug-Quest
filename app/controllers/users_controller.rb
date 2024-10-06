class UsersController < ApplicationController
  before_action :authenticate_user, {only: [:edit, :update, :show, :index]}
  before_action :forbid_login_user, {only: [:new, :create, :login_form, :login]}
  before_action :ensure_correct_user, {only: [:edit, :update]}
  
  
  def new
    @user = User.new
  end

  def login

  end

  def login_form
    @user = User.find_by(email: params[:email])
    
    if @user&.authenticate(params[:password])
      session[:user_id] = @user.id
      flash[:notice] = "ログイン成功"
      redirect_to("/games/game_top")
    else
      @error_message = "メールアドレスまたはパスワードが間違ってます"
      @email = params[:email]
      @password = params[:password]
      render("users/login")
    end
  end

  def logout
    session[:user_id] = nil
    flash[:notice] = "ログアウトしました"
    redirect_to("/")
  end

  def index
    @users = User.all
  end

  def show
    set_user_and_likes
    calculate_user_scores
  end

  def showlike
    set_user_and_likes
    calculate_user_scores
  end

  private

  def set_user_and_likes
    @user = User.find_by(id: params[:id])
    if @user.nil?
      flash[:alert] = "ユーザーが見つかりません"
      redirect_to("/users/index") and return
    end
    @liked_posts = @user.likes.map(&:post)
  end

  def calculate_user_scores
    if @user.score.nil? ||
       @user.score.cashier_score.nil? ||
       @user.score.claim_score.nil? ||
       @user.score.order_score.nil? ||
       @user.score.replenishing_score.nil?
      @user_level = 1
    else
      @user_level = 1024 - (
        @user.score.cashier_score + 
        @user.score.claim_score + 
        @user.score.order_score + 
        @user.score.replenishing_score
      )
    end

    # cashier_scoreの処理
    @cashier_score = @user.score.nil? || @user.score.cashier_score.nil? ? 1 : (333 - @user.score.cashier_score) * 3

    # claim_scoreの処理
    @claim_score = @user.score.nil? || @user.score.claim_score.nil? ? 1 : (333 - @user.score.claim_score) * 3

    # order_scoreの処理
    @order_score = @user.score.nil? || @user.score.order_score.nil? ? 1 : (333 - @user.score.order_score) * 3

    # replenishing_scoreの処理
    @replenishing_score = @user.score.nil? || @user.score.replenishing_score.nil? ? 1 : (333 - @user.score.replenishing_score) * 3
  end



  def create
    @user = User.new(name: params[:name], email: params[:email], password: params[:password], image_name: "default_user.gif")  # 9月27日10時34分修正実施
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "ユーザー登録が完了しました"
      redirect_to("/games/game_top")
    else
      render("users/new")
    end
  end

  def edit
    @user = User.find_by(id: params[:id])
  end

  def update
    @user = User.find_by(id: params[:id])
    @user.name = params[:name]
    @user.email = params[:email]
    @user.password = params[:password]  # 9月27日10時34分修正実施

    if params[:image].present?
      # 画像ファイルを取得
      image = params[:image]
      # ファイル名を設定
      @user.image_name = "#{@user.id}.jpg"
      # ファイルパスを指定
      file_path = Rails.root.join('public', 'user_images', @user.image_name)
      # バイナリデータを書き込み
      File.binwrite(file_path, image.read)
    end

    if @user.save
      flash[:notice] = "ユーザー情報を編集しました"
      redirect_to("/users/#{@user.id}")
    else
      render("users/edit")
    end
  end

  def ensure_correct_user 
    if @current_user.id != params[:id].to_i
      flash[:notice]="権限がありません"
      redirect_to("/posts/index")
    end
  end

  def likes
    @user = User.find(params[:id])
    @liked_posts = @user.likes.map(&:post) # ユーザーが「いいね！」した投稿を取得
  end





end
 