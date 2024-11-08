class Public::UsersController < ApplicationController
  def mypage
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def show
    @user = User.find(params[:id])
  end

  #退会確認画面
  def unsubscribe
    @user = current_user
  end
  
  #退会処理
  def withdraw
    def withdraw
      @user = current_user
      @user.update(is_active: false)
      reset_session
      flash[:notice] = "退会処理を実行いたしました"
      redirect_to root_path
    end

private
def customer_params
  params.require(:user).permit(:name,:password, :specify_field, :introduction,:is_active,:profile_image, :email)
end
