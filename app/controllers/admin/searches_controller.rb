class Admin::SearchesController < ApplicationController
    
  def search
      @range = params[:range] 
      @word = params[:word]
      @search = params[:search]
      
      if @range == "user"
       @records = User.search_for(@word, @search)
      else    
       @records = Post.search_for(@word, @search)
       @tag_list = Tag.all
      end
  end    
end
