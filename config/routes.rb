Rails.application.routes.draw do
  # web
  root to: 'top#index'
  get 'top/judge' => 'top#judge'
  post 'top/judge' => 'top#judge'

  # web
  mount BASE::API => '/'
end
