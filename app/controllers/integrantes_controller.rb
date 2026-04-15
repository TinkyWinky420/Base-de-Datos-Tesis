class IntegrantesController < ApplicationController

  def motivo
    @integrante = Integrante.find(params[:id])
  end

  def verificar_motivo
    session[:motivo] = params[:motivo]
    redirect_to clave_integrante_path(params[:id])
  end

  def clave
    @integrante = Integrante.find(params[:id])
  end

  def eliminar_confirmado
    @integrante = Integrante.find(params[:id])

    if params[:clave] == "0000"
      @integrante.destroy
      redirect_to nombres_path, notice: "Integrante eliminado correctamente"
    else
      redirect_to clave_integrante_path(@integrante), alert: "Clave incorrecta"
    end
  end

end