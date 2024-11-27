class Public::PostsController < ApplicationController
  before_action :authenticate_user!, only:[:new,:show,:edit,:update, :index]
  before_action :is_matching_login_user, only: [:edit, :update, :destroy]
  #新規投稿画面
  def new
    @post = Post.new
  end
  #投稿処理
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
     # 受け取った値を,で区切って配列にする
    tag_list = params[:post][:name].split(',')
    if @post.save
      @post.save_tags(tag_list)
      redirect_to post_path(@post), notice: "投稿が完了しました。"   #投稿後詳細画面へ
    else
      render :new #投稿失敗時はそのまま
    end
  end
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
      redirect_to post_path(@post), notice: "編集が完了しました。" # 編集後詳細画面へ
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
    @post = Post.includes(image_attachments: :blob).find(params[:id])
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
      #処理速度軽減,N+1問題の解消
        @posts = Post.visible
             .order(created_at: :desc)
             .includes(:tags, :user, image_attachments: :blob)
    end
    @tag_list = Tag.all
    @posts = @posts.page(params[:page]).per(8)
  end
  #投稿削除処理
  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end

  private
  #許可する投稿のパラメータ
  def post_params
    params.require(:post).permit(:title, :body, :is_active, :status,image: []).tap do |whitelisted|
      # is_activeが"true"ならtrueに変換、"false"ならfalseに変換
      whitelisted[:is_active] = ActiveModel::Type::Boolean.new.cast(whitelisted[:is_active])
    end
  end
  def is_matching_login_user

    post = Post.find(params[:id])

   unless post.user == current_user

      redirect_to posts_path

   end
  end

end