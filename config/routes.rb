Rails.application.routes.draw do
  #URLユーザー側変更
  devise_for :users, controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}
#管理者ログイン機能
devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}


  #public側機能
  scope module: :public do

      #ホーム画面
    root to: "homes#top"

    #アバウトページ
    get "/about" => "homes#about", as: "about"

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
    resources :posts, only:[:index, :show, :new, :create, :edit, :update, :destroy]do
      resources :post_comments, only: [:new, :show, :create, :edit, :update, :destroy]
    end  
    #ユーザー基本機能
    resources :users, only:[:show]
    #検索機能
    get "search" => "searches#search"
  end

  namespace :admin do
    resources :posts, only:[:index, :show, :new, :create, :edit, :update, :destroy]do
      resources :post_comments, only: [:new, :show, :create, :edit, :update, :destroy]
    end 
    resources :users, only: [:index, :show, :edit, :update]
    get "/admin" => "homes#top"
    get "search" => "searches#search"
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
