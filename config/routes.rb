Rails.application.routes.draw do
  get 'admin_area/users'
  resources :select_options
  resources :categories
  resources :roles
  resources :accounts do
    member do
      get 'area_chart_data'
      get 'donut_chart_data'
      get 'data_overview'
      get 'manage_categories'
    end
    collection do
      get 'my_accounts', as: "my_accounts"
    end
  end

  get 'accounts/:id/:start_date/:end_date', to: 'accounts#show'


  resources :work_times
  devise_for :users
  root 'static_pages#welcome'
  get 'static_pages/welcome'
  get 'static_pages/pricing', as: "pricing"


  #test
  if Rails.env.development?
    get 'test/generate_json_of_translation'
    get 'test/create_users'
    get 'test/create_accounts'
    get 'test/create_work_times'
    get 'test/destroy_all_users'
    get 'test/destroy_all_accounts'
    get 'test/destroy_all_work_times'
    get 'test/destroy_all_categories'
    get 'test/destroy_all_select_options'
    get 'test/create_select_options_only_json(/:name_of_file)', to: 'test#create_select_options_only_json'
    get 'test/create_categories_only_json(/:name_of_file)', to: 'test#create_categories_only_json'
    get 'test/create_work_times_only_json(/:name_of_file)', to: 'test#create_work_times_only_json'
    get 'test/create_users_only_json(/:name_of_file)', to: 'test#create_users_only_json'
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
