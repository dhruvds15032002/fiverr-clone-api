Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  devise_for :users,
             controllers: {
               sessions: 'users/sessions',
               registrations: 'users/registrations'
             }

  # You can namespace your API if you like:
  namespace :api do
    namespace :v1 do
      resources :gigs, only: %i[index show create update destroy]
      resources :orders, only: %i[index show create update]
      resources :reviews, only: %i[index create]
    end
  end
end
