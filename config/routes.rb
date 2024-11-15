Rails.application.routes.draw do
  #URLユーザー側変更
  devise_for :users, controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

  #ホーム画面
  root to: "homes#top"

  #アバウトページ
  get "/about" => "homes#about", as: "about"

  #public側機能
  scope module: :public do

    #マイページ
    get  '/mypage' => 'users#mypage', as: "mypage"

    #退会確認画面
    get  '/users/confilm' => 'users#confilm'

    #退会処理(論理削除)→復旧可
    patch '/users/withdraw' => 'users#withdraw'

    #編集画面
     get  '/users/information/edit' => 'users#edit'

    #編集処理
    patch '/users/information' => 'users#update'

    #投稿各機能
    resources :posts, only:[:index, :show, :new, :create, :edit, :update, :destroy]

    #ユーザー基本機能
    resources :users, only:[:show]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
