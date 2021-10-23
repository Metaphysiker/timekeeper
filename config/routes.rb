Rails.application.routes.draw do
  devise_for :users
  root 'static_pages#welcome'
  get 'static_pages/welcome'
  get 'static_pages/pricing', as: "pricing"


  #test
  if Rails.env.development?
    get 'test/generate_json_of_translation'
    get 'test/create_users'
    get 'test/destroy_all_users'
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
