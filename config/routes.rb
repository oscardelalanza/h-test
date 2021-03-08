Rails.application.routes.draw do
  devise_for :owners, controllers: { registrations: 'owners/registrations' }, path: 'owners',
             path_names: { registrations: 'register '}, defaults: { format: :json }
  resources :properties, defaults: { format: :json }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
