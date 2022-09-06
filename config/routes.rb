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
 end



  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
