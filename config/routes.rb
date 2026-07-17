Rails.application.routes.draw do
  get "administrativo", to: "administrativo#index"
  get "home/index"
  get "login", to: "sesiones#login"
  post "login", to: "sesiones#procesar_login"
  get "logout", to: "sesiones#logout"
  get "historial", to: "historial#index"
  get "estadisticas", to: "estadisticas#index"

  resources :zonas, only: [:index, :create, :update, :destroy]
  resources :plantels, only: [:create, :destroy]
  resources :nombres, path: "bases" do
    member do
      get :motivo
      post :clave
      post :confirmar_eliminacion
      get :documento
      post :descargar_documento
    end

    collection do
      get :buscar
      get :revisar
      get :sugerencias
    end
  end

  root "home#index"
end