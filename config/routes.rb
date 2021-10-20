Rails.application.routes.draw do
  devise_for :users
  root 'static_pages#welcome'
  get 'static_pages/welcome'
  get 'static_pages/pricing', as: "pricing"

  #test
  get 'test/generate_json_of_translation'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
