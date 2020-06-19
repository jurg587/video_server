Rails.application.routes.draw do
  scope :v1, module: :v1 do
    get 'rooms/search(.:format)', to: 'rooms#search'
    get 'rooms/:guid(.:format)', to: 'rooms#show'
    post 'rooms/join(.:format)', to: 'rooms#join'
    delete 'rooms/leave(.:format)', to: 'rooms#leave'
    put 'rooms/change_host(.:format)', to: 'rooms#change_host'
    resources :rooms, only: [:create]

    post 'users/sign_in(.:format)', to: 'users#sign_in'
    post 'users/register(.:format)', to: 'users#register'
    put 'users(.:format)', to: 'users#update'
    delete 'users(.:format)', to: 'users#destroy'
    resources :users, only: [:index]
  end
end
