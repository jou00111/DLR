class Public::PostsController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update, :destroy]
  #新規投稿画面
  def new
    @post = Post.new
  end
  #投稿処理
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
     Rails.logger.debug "Post params: #{@post.inspect}"
    if @post.save
      redirect_to post_path(@post), notice: "You have created post successfully."   #投稿後詳細画面へ
    else
      render :new #投稿失敗時はそのまま
    end
  end
  #編集画面
  def edit
    @post = Post.find(params[:id])
  end
  #編集処理
  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)  # 修正: post_params を渡す
      redirect_to post_path(@post), notice: "You have updated post successfully." # 編集後詳細画面へ
    else
      render :edit  # 編集失敗時はそのまま
    end
  end
  #投稿詳細画面
  def show
    @post = Post.find(params[:id])
    @user = @post.user
    @post_comments = @post.post_comments
     #非公開状態の制限
    unless @post.is_active || @post.user == current_user
      redirect_to posts_path, alert: "この投稿は非公開です。"
    end
  end
  #投稿一覧
  def index
    @posts = Post.visible.order(created_at: :desc)
  end
  #投稿削除処理
  def destroy
    @post = Post.find(params[:id])
    @post.delete
    redirect_to posts_path
  end

  private
  #許可する投稿のパラメータ
  def post_params
    params.require(:post).permit(:title, :body, :is_active, :image, :status).tap do |whitelisted|
      # is_activeが"true"ならtrueに変換、"false"ならfalseに変換
      whitelisted[:is_active] = ActiveModel::Type::Boolean.new.cast(whitelisted[:is_active])
    end
  end
  #ユーザー確認
  def is_matching_login_user

    post = Post.find(params[:id])

   unless post.user == current_user

      redirect_to posts_path

   end
  end
end