class Public::SearchesController < ApplicationController
    
  def search
      @range = params[:range] 
      @word = params[:word]
      @search = params[:search]
      
      if @range == "user"
       @records = User.search_for(@word, @search,current_user)
      else    
       @records = Post.search_for(@word, @search,current_user)
       @tag_list = Tag.all
      end
  end    
end
