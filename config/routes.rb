Rails.application.routes.draw do
  root 'static_pages#welcome'
  get 'static_pages/welcome'

  #test
  get 'test/generate_json_of_translation'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
