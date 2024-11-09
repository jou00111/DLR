class Public::PostsController < ApplicationController
  #新規投稿画面
  def new
    @post = Post.new
  end
  #投稿処理
  def create
    @post = Post.new(post_params)
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
    if @post.update
      redirect_to post_path(@post), notice: "You have updated post successfully." #編集後詳細画面へ
    else
      render :edit  #投稿失敗時はそのまま
    end
  end
  #投稿詳細画面
  def show
    @post = Post.find(params[:id])
  end
  #投稿一覧
  def index
    @posts = Post.all
  end
end

  private
  #許可する投稿のパラメータ
  def post_params
    params.require(:post).permit(:title, :body, :post_image,:is_active)
  end