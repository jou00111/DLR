Rails.application.routes.draw do
  namespace :public do
    get 'posts/new'
    get 'posts/edit'
    get 'posts/show'
    get 'posts/index'
  end
  namespace :public do
    get 'users/mypage'
    get 'users/edit'
    get 'users/show'
    get 'users/confilm'
  end
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
    get  '/mypage' => 'users#show', as: "mypage"
    get  '/users/mypage' => 'users#confilm'
    patch '/users/withdraw' => 'users#withdraw'
    resources :posts, only:[:index, :show, :new, :create, :edit, :update, :destroy]
    resources :users, only:[:edit, :update, :destroy]
  end 

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
