class Public::UsersController < ApplicationController
  # マイページ
  def mypage
    @user = current_user
    @posts = @user.posts
  end

  # 編集画面
  def edit
    @user = current_user
  end

  # ユーザー詳細画面
  def show
    @user = User.find(params[:id])
    @posts = @user.posts
    @currentUserEntry=Entry.where(user_id: current_user.id)
    @userEntry=Entry.where(user_id: @user.id)
    if @user.id == current_user.id
    else
      @currentUserEntry.each do |cu|
        @userEntry.each do |u|
          if cu.room_id == u.room_id then
            @isRoom = true
            @roomId = cu.room_id
          end
        end
      end
      if @isRoom
      else
        @room = Room.new
        @entry = Entry.new
      end
    end
  end
  
  # 退会確認画面
  def unsubscribe
    @user = current_user
  end
  def update
  @user = current_user
  current_password = params[:user][:current_password]

  # 現在のパスワードを確認
  if params[:user][:change_password] == "1" # パスワード変更フラグがオンの場合
    # 現在のパスワードを確認
     if @user.valid_password?(current_password)  # Deviseのメソッドを使用
      if @user.update(user_params)
        sign_in(@user, bypass: true)  # bypass: true で再ログイン
        redirect_to mypage_path, notice: 'プロフィールを更新しました。'
      else
        flash.now[:alert] = '更新に失敗しました。'
        render :edit
      end
    else
      flash.now[:alert] = '現在のパスワードが正しくありません。'
      render :edit
    end
  else
    # パスワードが空の場合、パスワード関連フィールドは無視して更新
    if @user.update(user_params.except(:password, :password_confirmation, :current_password))
      redirect_to mypage_path, notice: 'プロフィールを更新しました。'
    else
      flash.now[:alert] = '更新に失敗しました。'
      render :edit
    end
  end
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
    permitted_params = params.require(:user).permit(:name, :password, :password_confirmation, :current_password, :specify_field, :introduction, :is_active, :profile_image, :email )

  
  
  # パスワード変更がない場合はパスワード関連のフィールドを削除
  if params[:user][:change_password] != "1" # パスワード変更がない場合
    permitted_params.delete(:password)
    permitted_params.delete(:password_confirmation)
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
