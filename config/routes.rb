Rails.application.routes.draw do
  devise_for :admins,skip: [:registrations, :passwords], controllers: {
  sessions: "admin/sessions"
}

  devise_for :users,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions',
  passwords: 'users/passwords'
}

root to: 'public/homes#top'

 scope module: :public do
    resource :post, only: [:update, :index, :show, :new, :create]

     resource :user, only: [:update, :index, :show, :edit]
     end

     scope module: :admin do
    resource :post, only: [:edit, :index, :show]

     resource :user, only: [:index, :show, :edit]
     end

     resources :posts do
      resource :favorites, only: [:create, :destroy]
     end

     get "search" => "searches#search"

     devise_scope :user do
      post 'public/guest_sign_in', to: 'public/sessions#guest_sign_in'
     end


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end
