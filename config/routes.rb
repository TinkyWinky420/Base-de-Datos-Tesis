Rails.application.routes.draw do
  get "home/index"

  resources :nombres, path: "bases" do
    collection do
      get :buscar
    end
  end

  root "home#index"
end