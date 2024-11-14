class Public::PostCommentsController < ApplicationController
  #投稿画面
  def new
    @post = Post.find(params[:post_id]) 
    @post_comment = @post.post_comments.new  # 新しいコメントを作成
  end

  #投稿処理
  def create
    @post = Post.find(params[:post_id])
    @post_comment = current_user.post_comments.new(post_comment_params)
    @post_comment.save
    redirect_to post_path(@post)
  end

  #詳細画面
  def show
    @post_comment = PostComment.find(params[:id])
  end

  #編集画面
  def edit
    @post_comment = PostComment.find(params[:id])
  end

  #編集処理
  def update
    @post_comment = PostComment.find(params[:id])
    @post = @post_comment.post
    @post_comment.update(post_comment_params)
    redirect_to post_path(@post)
  end

  #コメント削除
  def destroy
    @post_comment = PostComment.find(params[:id])
    @post_comment.delete
    redirect_to posts_path
  end

  private
  #許可するパラメーター

  def post_comment_params
    params.require(:post_comment).permit(:title, :body,)
  end

end
