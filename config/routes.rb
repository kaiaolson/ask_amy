Rails.application.routes.draw do

  match "/delayed_job" => DelayedJobWeb, :anchor => false, via: [:get, :post]

  # main job of the routes: you map a request to a controller with an action
  get "/hello" => "welcome#index"
  get "/about" => "welcome#about"

  # providing the :as option will give us a route helper method
  # it will override the default one, if any; only loop the path portion
  # of the route, not the HTTP verbs
  # helper methods must be unique
  get "/hello/:name" => "welcome#greet", as: :greet

  get "/subscribe" => "subscribe#index"
  post "/subscribe" => "subscribe#create"

  # get "/questions/new" => "questions#new", as: :new_question
  # post "/questions" => "questions#create", as: :questions
  # get "/questions/:id" => "questions#show", as: :question
  # get "/questions/:id/edit" => "questions#edit", as: :edit_question
  # patch "/questions/:id" => "questions#update"
  # delete "/questions/:id" => "questions#destroy"

  resources :questions do
    # use on collection when not targeting particular record
    get   :search,    on: :collection
    # use on member when targeting particular record of type question
    patch :mark_done, on: :member
    # use nothing when targeting antoher record not the question itself
    post  :approve

    # by defining resources :answers nested inside resources questions, Rails
    # will define all the answers route prepended with /questions/question_id
    # this enables us to have the question_id handy so we can create the answer
    # associated with a question with question_id
    resources :answers, only: [:create, :edit, :update, :destroy]

    resources :likes, only: [:create, :destroy]
    resources :favorites, only: [:create, :destroy]
    resources :votes, only: [:create, :update, :destroy]
  end

  resources :favorites, only: [:index]

  # do this to avoid triple nesting comments under resources :answers within
  # the resources :questions, as it will be very cumbersome to generate routes
  # and use forms; we don't need another set of answers routes in here, so
  # we pass the only: [] option to it
  resources :answers, only: [] do
    resources :comments, only: [:create, :destroy]
  end

  resources :users, only: [:create, :new]

  resources :sessions, only: [:new, :create, :destroy] do
    delete :destroy, on: :collection
  end
  # # can use the same path for this one as the one we used for questions#create
  # get "/questions" => "questions#index"

  # this does everything above.
  resources :questions
  root "welcome#index"



  # this will map any GET request with path "/hello" to WelcomeController and
  # index action within that controller

  # every user request in Rails must be handled by a controller and action - action is method within the controller

end
