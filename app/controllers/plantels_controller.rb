class PlantelsController < ApplicationController

def create
  @plantel = Plantel.new(plantel_params)

  if @plantel.save
    redirect_to zonas_path,
                notice: "Plantel agregado correctamente."
  else
    redirect_to zonas_path,
                alert: "Ese plantel ya existe en esta zona."
  end
end

  def destroy
    @plantel = Plantel.find(params[:id])

    @plantel.destroy

    redirect_to zonas_path,
                notice: "Plantel eliminado correctamente."
  end

  private

  def plantel_params
    params.require(:plantel).permit(
      :nombre,
      :zona_id
    )
  end

end