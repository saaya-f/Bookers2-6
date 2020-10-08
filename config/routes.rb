Rails.application.routes.draw do
  get 'search/search'
  root :to => "homes#top"
  get "home/about" => "homes#about"
  devise_for :users
  #↑ devise利用時にURLとしてusersを含むことを示す
  resources :books do
    resource :favorites, only: [:create, :destroy]
    #idの受け渡しが必要ないからresource(単数形)
    resources :book_comments, only: [:create, :destroy]
  end
  patch "/books" => "books#create"
  delete "/books" => "books#destroy"
  resources :users, only: [:index, :show, :edit, :update] do
    member do
      get :following, :followers
    end
    resource :relationships, only: [:create, :destroy]
    # id受け渡し必要なし
  end
  get 'user/:id/search' => 'users#search'
  get 'books/:id/search' => 'books#search'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
