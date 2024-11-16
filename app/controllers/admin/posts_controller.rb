class Admin::PostsController < ApplicationController
    #投稿詳細画面
    def show
      @post = Post.find(params[:id])
      @user = @post.user
      @post_comments = @post.post_comments
    end
    #投稿一覧
    def index
      @posts = Post.all
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
end
