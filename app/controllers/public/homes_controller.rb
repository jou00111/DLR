class Public::HomesController < ApplicationController
  def top
    @posts = Post.limit(6).order(created_at: :desc) # 最新6件を取得
  end
  def about
  end
end
