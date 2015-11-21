Rails.application.routes.draw do
  get 'users/show'

  devise_for :users

  resources :questions do
    resources :answers
    post :add_favourite, on: :member
    post :remove_favourite, on: :member
    post :vote_up, on: :member
    post :vote_down, on: :member
  end

  resources :users


  root 'questions#index'
end
