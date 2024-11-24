class Public::HomesController < ApplicationController
  def top
    @posts = Post.limit(6).order(created_at: :desc) # 最新6件を取得
    
    # 各投稿に対する平均評価を計算して渡す
    @posts_with_avg_rating = @posts.map do |post|
      avg_rating = post.post_comments.average(:star).to_f
      avg_rating = 0.0 if avg_rating.nil?  # コメントがない場合の対策
      { post: post, average_star: avg_rating }
    end
  end

  def about
  end
end
