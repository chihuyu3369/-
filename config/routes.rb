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

    get '/users/list' => 'users#index', as: 'users_list'

    resources :post, only: [:update, :index, :show, :new, :create]

    resources :user, only: [:update, :show, :edit]
     end

 scope module: :admin do
    resources :post, only: [:edit, :index, :show]

    resources :user, only: [:index, :show, :edit]
     end

 resources :posts do
    resources :favorites, only: [:create, :destroy]
     end

     get "search" => "searches#search"

     devise_scope :user do
      post 'public/guest_sign_in', to: 'public/sessions#guest_sign_in'
     end


   #For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end
