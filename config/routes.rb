Rails.application.routes.draw do
  root 'home#index'
  post '/home/index' => 'home#index' , as: :home_index
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
