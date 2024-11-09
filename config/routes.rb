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
    get  '/mypage' => 'users#mypage', as: "mypage"
    get  '/users/mypage' => 'users#confilm'
    patch '/users/withdraw' => 'users#withdraw'
    resources :posts, only:[:index, :show, :new, :create, :edit, :update, :destroy]
    resources :users, only:[:edit, :update, :destroy]
  end 

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
