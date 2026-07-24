class PlantelCarrerasController < ApplicationController

  def index
    @zonas = Zona.order(:nombre)
  end

  def carreras
    plantel = Plantel.find(params[:id])

    render json: {
      carreras: Carrera.order(:nombre).map do |carrera|
        {
          id: carrera.id,
          nombre: carrera.nombre,
          seleccionada: plantel.carrera_ids.include?(carrera.id)
        }
      end
    }
  end

  def update
    plantel = Plantel.find(params[:id])

    plantel.carrera_ids = params[:carrera_ids] || []

    head :ok
  end

end