class Public::UsersController < ApplicationController
  # マイページ
  def mypage
    @user = current_user
  end

  # 編集画面
  def edit
    @user = current_user
  end

  # ユーザー詳細画面
  def show
    @user = User.find(params[:id])
  end

  # 退会確認画面
  def unsubscribe
    @user = current_user
  end
  def update
    @user = current_user
    @user.update(user_params)
    redirect_to current_user
  end
  # 退会処理
  def withdraw
    @user = current_user
    @user.update(is_active: false)
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to root_path
  end

  private

  # 会員の許可するパラメータ
  def user_params
    permitted_params = params.require(:user).permit(:name, :password, :password_confirmation, :current_password, :specify_field, :introduction, :is_active, :profile_image, :email)

    # パスワードが空の場合は、パスワードフィールドを削除
    if permitted_params[:password].blank?
      permitted_params.delete(:password)
      permitted_params.delete(:password_confirmation)
    end

    # 現在のパスワードが空の場合は、現在のパスワードフィールドを削除
    if permitted_params[:current_password].blank?
      permitted_params.delete(:current_password)
    end

    permitted_params
  end

  # 会員の論理削除、退会済みのアカウントを利用停止
  def reject_user
    @user = User.find_by(name: params[:user][:name])
    
    # 退会済みのユーザーかどうかのチェック
    if @user && @user.valid_password?(params[:user][:password]) && !@user.is_active
      flash[:alert] = "退会済みです。再度ご登録をしてご利用ください"
      redirect_to new_user_registration_path
    else
      flash[:alert] = "項目を入力してください"
    end
  end
end
