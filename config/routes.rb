Rails.application.routes.draw do
  get "home/index"

  resources :nombres, path: "bases" do
    collection do
      get :buscar
    end
  end

  resources :integrantes do
    member do
      get :motivo
      post :verificar_motivo
      get :clave
      post :eliminar_confirmado
    end
  end

  root "home#index"
end