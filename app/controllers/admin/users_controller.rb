class Admin::UsersController < ApplicationController
    
    # ユーザー詳細画面
    def show
      @user = User.find(params[:id])
      @posts = @user.posts
    end

    # ユーザー詳細画面
    def index
      @users = User.all
    end

    # 編集画面
    def edit
      @user = current_user
    end

    def update
      @user = current_user
      if @user.update(user_params)  # 修正: post_params を渡す
        redirect_to mypage_path, notice: "You have updated information successfully." # 編集後マイページ画面へ
      else
        render :edit  # 編集失敗時はそのまま
      end
    end

    private
  
    # 会員の許可するパラメータ
    def user_params
      permitted_params = params.require(:user).permit(:name, :password, :password_confirmation, :current_password, :specify_field, :introduction, :is_active, :profile_image, :email )
    end
  end