Rails.application.routes.draw do
  devise_for :users
  get '/users/:id' => 'users#show', as: 'users'
  resources :posts, :path => '/' do
    post 'comment' => 'posts#create_comment'
    get 'comment/:id' => 'posts#edit_comment'
    patch 'comment/:id' => 'posts#update_comment'
    delete 'comment/:id' => 'posts#destroy_comment'
  end
end
