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
      tesis = @integrante.tesis
      @integrante.destroy
      session[:motivo] = nil
      redirect_to edit_nombre_path(tesis), notice: "Integrante eliminado correctamente"
    else
      redirect_to clave_integrante_path(@integrante), alert: "Clave incorrecta"
    end
  end

end
