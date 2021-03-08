Rails.application.routes.draw do
  defaults format: :json do
    devise_for :owners, controllers: { registrations: 'owners/registrations' }, path: 'owners',
               path_names: { registrations: 'register '}
    resources :properties
    resources :partners, only: :create
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
