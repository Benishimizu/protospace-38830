Rails.application.routes.draw do

  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: "prototypes#index"
  # resources :prototypes //7つのアクションが生成されてしまう
  # https://master.tech-camp.in/v2/curriculums/4220
  # https://master.tech-camp.in/v2/curriculums/4219

  resources :prototypes, only: [:show, :index, :create, :new]
end
