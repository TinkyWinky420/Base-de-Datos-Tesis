Rails.application.routes.draw do
  get "home/index"

  get "login", to: "sesiones#login"
  post "login", to: "sesiones#procesar_login"
  get "logout", to: "sesiones#logout"

  get "historial", to: "historial#index"

  resources :nombres, path: "bases" do
    member do
      get :motivo
      post :clave
      post :confirmar_eliminacion
    end

    collection do
      get :buscar
      get :revisar
    end
  end

  root "home#index"
end