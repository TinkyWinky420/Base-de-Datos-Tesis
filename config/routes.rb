Rails.application.routes.draw do
  get "historial/index"
  get "home/index"

  get "historial", to: "historial#index"

  resources :nombres, path: "bases" do
    member do
      get :motivo
      post :clave
      post :confirmar_eliminacion
    end

    collection do
      get :buscar
    end
  end

  root "home#index"
end