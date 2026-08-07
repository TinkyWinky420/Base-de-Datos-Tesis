Rails.application.routes.draw do
  get "administrativo", to: "administrativo#index"
  get "home/index"
  get "login", to: "sesiones#login"
  post "login", to: "sesiones#procesar_login"
  get "logout", to: "sesiones#logout"
  get "historial", to: "historial#index"
  get "estadisticas", to: "estadisticas#index"

  resources :zonas, only: [:index, :create, :update, :destroy]

  get "zonas/:id/planteles", to: "zonas#planteles"

  resources :plantels, only: [:create, :destroy]

  resources :plantel_carreras, only: [:index] do
    member do
      get :carreras
      patch :update
    end
  end

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

  get "integrantes/:id/motivo", to: "integrantes#motivo", as: "motivo_integrante"
  post "integrantes/:id/verificar_motivo", to: "integrantes#verificar_motivo", as: "verificar_motivo_integrante"
  get "integrantes/:id/clave", to: "integrantes#clave", as: "clave_integrante"
  post "integrantes/:id/eliminar_confirmado", to: "integrantes#eliminar_confirmado", as: "eliminar_confirmado_integrante"

  root "home#index"
end