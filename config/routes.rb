Rails.application.routes.draw do

# 管理者用
devise_for :admins, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}

# 顧客用
devise_for :users,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

 scope module: :public do
  root to: 'homes#top'
  resources :posts, only: [:new, :create, :index, :show, :destroy]do
   resources :likes, only: [:create, :index]
   resource :likes, only: [:destroy]
   resources :greats, only: [:create, :index]
   resource :greats, only: [:destroy]
   resources :amazings, only: [:create, :index]
   resource :amazings, only: [:destroy]
   resources :comments, only: [:create, :destroy]
   
  end
  get "search" => "searches#search"

  resources :users, only: [:show, :edit, :update]
 end



  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
