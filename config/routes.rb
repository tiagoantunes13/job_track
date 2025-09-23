Rails.application.routes.draw do
  resources :chats do
    resources :messages, only: [:create]
  end
  resources :models, only: [:index, :show] do
    collection do
      post :refresh
    end
  end
  resources :job_applications do
    member do
      get :generate_cover_letter
    end
  end
  resources :jobs
  post 'from_serpapi', to: 'jobs#from_serpapi', as: :from_serpapi
  resources :remote_analyses, only: [:new, :create]

  devise_for :users

  resources :contact_messages, only: [:new, :create]
  resources :resumes, only: [:new, :create]



  get 'job_search/list', to: 'job_search#list', as: 'job_search_list'
  post 'job_search/ignore_job', to: 'job_search#ignore_job', as: 'ignore_job'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  resource :profile, only: [:new, :create, :edit, :update]
  # Defines the root path route ("/")
  root "pages#landing"
  
  get 'pricing', to: 'pages#pricing', as: 'pricing'
  get 'features', to: 'pages#features', as: 'features'
  get 'testimonials', to: 'pages#testimonials', as: 'testimonials'
  get 'contact', to: 'pages#contact', as: 'contact'
end
