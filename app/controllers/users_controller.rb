class UsersController < ApplicationController
  before_action :authenticate_user, only: [:edit, :update, :show, :index]
  before_action :forbid_login_user, only: [:new, :create, :login_form, :login]
  before_action :ensure_correct_user, only: [:edit, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.image_name = "default_user.gif"
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "ユーザー登録が完了しました"
      redirect_to("/games/game_top")
    else
      render :new
    end
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
      flash[:alert] = "メールアドレスまたはパスワードが間違っています"
      render :login
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


  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.assign_attributes(user_params)
    if params[:image].present?
      save_user_image
    end

    if @user.save
      flash[:notice] = "ユーザー情報を編集しました"
      redirect_to("/users/#{@user.id}")
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def set_user_and_likes
    @user = User.find_by(id: params[:id])
    if @user.nil?
      flash[:alert] = "ユーザーが見つかりません"
      redirect_to("/users/index") and return
    end
    @liked_posts = @user.likes.map(&:post)
  end

  def calculate_user_scores
    @user_level = 1024 - (
      @user.score&.cashier_score.to_i +
      @user.score&.claim_score.to_i +
      @user.score&.order_score.to_i +
      @user.score&.replenishing_score.to_i
    )
    @cashier_score = score_calculator(@user.score&.cashier_score)
    @claim_score = score_calculator(@user.score&.claim_score)
    @order_score = score_calculator(@user.score&.order_score)
    @replenishing_score = score_calculator(@user.score&.replenishing_score)
  end

  def score_calculator(score)
    score.nil? ? 1 : (333 - score) * 3
  end

  def save_user_image
    image = params[:image]
    @user.image_name = "#{@user.id}.jpg"
    file_path = Rails.root.join('public', 'user_images', @user.image_name)
    File.binwrite(file_path, image.read)
  end

  def ensure_correct_user
    if @current_user.id != params[:id].to_i
      flash[:alert] = "権限がありません"
      redirect_to("/posts/index")
    end
  end
end
