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
  get "about" => "homes#about", as: "about"

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
