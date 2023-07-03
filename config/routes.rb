Rails.application.routes.draw do

  devise_for :employees, controllers: {
    sessions: "employees/sessions",
    registrations: "employees/registrations" }


  resources :employees do
    get "subordinates", on: :member
    get "queries", on: :member
    get "scores", on: :member
    get "managers", on: :collection
    put "role", on: :member
    get "reviews", on: :member
    get "current_employee_info", on: :collection
  end


  resources :questions do
    get "replies", on: :member
    put "query_answer", on: :member
    put "answer_opinion", on: :member
  end

  resources :answers
  resources :home_page 


  resources :points do
    put "manager_score", on: :member
  end

  resources :feedbacks do
    put "manager_feedback", on: :member 
    put "comments", on: :member
  end

end


