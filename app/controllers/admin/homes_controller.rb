class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!
  def top
     @posts = Post.order(created_at: :desc)
    @tag_list =Tag.all
    @posts = @posts.page(params[:page]).per(8)
  end
end
