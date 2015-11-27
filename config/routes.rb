Rails.application.routes.draw do
  devise_for :users, controllers: {omniauth_callbacks: 'omniauth_callbacks'}

  concern :commentable do
    resources :comments
  end

  concern :votable do
    post :vote_up, on: :member, controller: :votes
    post :vote_down, on: :member, controller: :votes
    delete :unvote, on: :member, controller: :votes
  end

  resources :questions, concerns: [:commentable, :votable], shallow: true do
    resources :answers, concerns: [:commentable, :votable]
    post :add_favourite, on: :member
    post :remove_favourite, on: :member
  end

  resources :users

  root 'questions#index'
  get 'comments/create'
  get 'users/show'
end
