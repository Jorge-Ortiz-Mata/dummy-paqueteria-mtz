Rails.application.routes.draw do
  # DEFAULT PRICES routes
  resources :default_prices, only: %i[edit update]

  # REMITENTS routes
  resources :remitents, except: %i[index show] do
    collection do
      post '/filter', to: 'remitents#filter'
    end

    resources :destinataries, except: %i[destroy]
  end

  post '/filter', to: 'destinataries#filter', as: 'filter_destinataries'

  # DEPARTURE_DATES routes
  resources :departure_dates do
    member do
      get 'export/csv', to: 'departure_dates#export_csv'
    end
  end

  # ADMIN routes
  namespace :admin do
    resources :users do
      patch '/update/profile', to: 'users#update_profile', on: :member
    end
  end

  # USER routes.
  resources :users, only: %i[create] do
    resources :profiles
  end

  # get '/signup', to: 'users#new'
  get '/users/:token_id', to: 'users#show', as: 'user'
  get '/users/edit/:token_id', to: 'users#edit', as: 'edit_user'
  patch '/users/edit/:token_id', to: 'users#update', as: 'update_user'
  delete '/users/destroy/:token_id', to: 'users#destroy', as: 'destroy_user'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#logout'
  get '/password/recover', to: 'sessions#recover', as: 'recover_password'
  post '/password/reset', to: 'sessions#reset_password', as: 'reset_password'
  get '/reset/password/form/:recover_password_token', to: 'sessions#reset_password_form', as: 'reset_password_form'
  post '/password/update', to: 'sessions#update_password', as: 'update_password'

  # SELLS routes
  resources :sells do
    member do
      get '/remitent_destinatary', to: 'sells#remitent_destinatary'
      get '/preview_remitent_destinatary', to: 'sells#preview_remitent_destinatary'
      patch '/update_remitent_destinatary', to: 'sells#update_remitent_destinatary'
      get 'edit/estafeta/info', to: 'sells#estafeta_info'
      patch 'update/estafeta/info', to: 'sells#update_estafeta_info'
      get '/export/pdf', to: 'sells#export_pdf'
      get '/whatsapp', to: 'sells#whatsapp'
      post '/send/whatsapp', to: 'sells#send_whatsapp'
      patch '/shipment_number', to: 'sells#shipment_number'
    end
    collection do
      post '/filter', to: 'sells#filter'
    end
    resources :article_sells
  end

  # ARTICLES routes
  resources :articles do
    collection do
      post '/search_by_name', to: 'articles#search_by_name'
      post '/filter', to: 'articles#filter'
      post '/estimate_price', to: 'articles#estimate_price'
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
  # root "articles#index"
  root 'pages#dashboard'
end
