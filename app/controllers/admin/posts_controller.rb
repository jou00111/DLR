class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!
  #編集画面
  def edit
    @post = Post.find(params[:id])
    @tag_list = @post.tags.pluck(:name).join(',')
  end
  #編集処理
  def update
    @post = Post.find(params[:id])
    tag_list = params[:post][:name].split(',')
    if @post.update(post_params)  # 修正: post_params を渡す
       @post.save_tags(tag_list)
      redirect_to admin_post_path(@post), notice: "投稿の編集を完了しました。" # 編集後詳細画面へ
    else
      render :edit  # 編集失敗時はそのまま
    end
  end
  
  def search_tag
    #検索結果画面でもタグ一覧表示
    @tag_list = Tag.left_joins(:posts).group(:id).order('COUNT(posts.id) DESC')
    @tag = Tag.find(params[:tag_id])
    @posts = @tag.posts.page(params[:page])  
  end
  
  #投稿詳細画面
  def show
    @post = Post.find(params[:id])
    @user = @post.user
    @post_comments = @post.post_comments
    @post_tags = @post.tags
     #非公開状態の制限
    unless @post.is_active || @post.user == current_user
      redirect_to posts_path, alert: "この投稿は非公開です。"
    end
  end
  #投稿一覧
  def index
    if params[:search].present?
      @posts = Post.posts_serach(params[:search])
    elsif params[:tag_id].present?
      @tag = Tag.find(params[:tag_id])
      @posts = @tag.posts.order(created_at: :desc)
    else
        @posts = Post.visible.order(created_at: :desc)
    end
    @tag_list = Tag.all
    @posts = Kaminari.paginate_array(@posts).page(params[:page]).per(8)
  end
  #投稿削除処理
  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to admin_posts_path
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
