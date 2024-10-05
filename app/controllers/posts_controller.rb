class PostsController < ApplicationController
  before_action :ensure_correct_user,{only: [:edit, :update, :destroy]}
  before_action :authenticate_user
  def index
    @posts = Post.all.order(created_at: :desc)
  end

  def show
    @id = params[:id]
    @post = Post.find_by(id: params[:id])
    @user = @post.user
    @likes_count = Like.where(post_id: @post.id).count
  end

  def new
    @post = Post.new  # 新規投��用インスタンスを生成
  end

  def edit
    @post = Post.find_by(id: params[:id])
  # URLの:idから投稿を取得
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = @current_user.id # 既に設定済み
    if @post.save
      redirect_to "/posts/index", notice: '投稿が成功しました。' # 9月27日修正実施
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @post = Post.find_by(id: params[:id])  # @postに代入
    if @post && @post.update(post_params)
      flash[:notice] = "投稿を編集しました"
      redirect_to "/posts/index", notice: '投稿が更新されました。'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post = Post.find_by(id: params[:id])
    if @post
      @post.destroy
      redirect_to "/posts/index", notice: "投稿が削除されました。"
    else
      redirect_to "/posts/index", alert: "投稿が見つかりませんでした。"
    end
  end

  def post_params
    params.require(:post).permit(:comment)  # 更新時に許可するパラメータを定義
  end
end
 

def ensure_correct_user
  @post = Post.find_by(id: params[:id])
  if @post.nil? || @current_user.id != @post.user_id
    flash[:notice] = "権限がありません"
    redirect_to("/posts/index")
  end

end
 