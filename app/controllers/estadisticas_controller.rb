class EstadisticasController < ApplicationController
  
  def index
    @zonas = Zona.order(:nombre)
    @zona_seleccionada = params[:zona_id]
    @total_tesis = 0
    @tesis = []
    @grafica = {}

    return if @zona_seleccionada.blank?

    @zona = Zona.find(@zona_seleccionada)
    @tesis = Nombre.where(zona: @zona.nombre)
    @total_tesis = @tesis.count
    @grafica = @tesis.group(:carrera).count
  end
end