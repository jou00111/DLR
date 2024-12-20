class Admin::PostCommentsController < ApplicationController
  before_action :authenticate_admin!
    #投稿画面
  def new
    @post = Post.find(params[:post_id]) 
    @post_comment = @post.post_comments.new  # 新しいコメントを作成
  end

  #投稿処理
  def create
    @post = Post.find(params[:post_id])
    @post_comment = @post.post_comments.new(post_comment_params)
    @post_comment.admin = current_admin
    if @post_comment.save
      redirect_to admin_post_path(@post), notice: "コメントを投稿しました"
    else
      Rails.logger.error "Failed to save PostComment: #{@post_comment.errors.full_messages}"
      render :new, status: :unprocessable_entity
    end
  end

  #詳細画面
   def show
    @post = Post.find(params[:post_id])
    @post_comment = PostComment.find(params[:id])
  
    # 投稿者情報を取得
    @user = @post_comment.user if @post_comment.user.present?
    @admin = @post_comment.admin if @post_comment.admin.present?
  end

  #編集画面
   def edit
    @post = Post.find(params[:post_id])
    @post_comment = PostComment.find(params[:id])
  
    # 投稿者情報を取得
    @user = @post_comment.user if @post_comment.user.present?
    @admin = @post_comment.admin if @post_comment.admin.present?
  end

  #編集処理
  def update
    @post = Post.find(params[:post_id])
    @post_comment = PostComment.find(params[:id])
    @post = @post_comment.post
    @post_comment.update(post_comment_params)
    redirect_to admin_post_path(@post)
  end

  #コメント削除
  def destroy
    @post_comment = PostComment.find(params[:id])
    @post_comment.delete
    redirect_to post_path(@post)
  end

  private
  #許可するパラメーター

  def post_comment_params
    params.require(:post_comment).permit(:title, :body, :star)
  end
end
