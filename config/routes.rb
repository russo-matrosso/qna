Rails.application.routes.draw do
  get 'comments/create'

  get 'users/show'

  devise_for :users

  concern :commentable do
    resources :comments
  end

  concern :votable do
    post :vote_up, on: :member, controller: :votes
    post :vote_down, on: :member, controller: :votes
  end

  resources :questions, concerns: [:commentable, :votable], shallow: true do
    resources :answers, concerns: [:commentable, :votable]
    post :add_favourite, on: :member
    post :remove_favourite, on: :member
  end

  resources :users


  root 'questions#index'
end
