Rails.application.routes.draw do
  root to: 'top#index'
  get 'top/judge' => 'top#judge'
  post 'top/judge' => 'topjudge'

  mount BASE::API => '/'
end
