class ZonasController < ApplicationController

  def index
    @zonas = Zona.order(:nombre)
    @zona = Zona.new
  end

  def create
    @zona = Zona.new(zona_params)

    if @zona.save
      redirect_to zonas_path,
                  notice: "Zona agregada correctamente."
    else
      redirect_to zonas_path,
                  alert: "La zona ya existe."
    end
  end

  def update
    @zona = Zona.find(params[:id])

    if @zona.update(zona_params)
      redirect_to zonas_path,
                  notice: "Zona actualizada correctamente."
    else
      @zonas = Zona.order(:nombre)
      render :index, status: :unprocessable_entity
    end
  end

  def destroy
    @zona = Zona.find(params[:id])

    @zona.destroy

    redirect_to zonas_path,
                notice: "Zona eliminada correctamente."
  end

  def planteles
    zona = Zona.find(params[:id])

    render json: zona.plantels.order(:nombre).select(:id, :nombre)
  end

  private

  def zona_params
    params.require(:zona).permit(:nombre)
  end

end