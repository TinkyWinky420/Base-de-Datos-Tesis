class SesionesController < ApplicationController

  def login
  end

  def procesar_login
    if params[:usuario] == "alumno" && params[:password] == "1234"
      session[:rol] = "alumno"

    elsif params[:usuario] == "asesor" && params[:password] == "1234"
      session[:rol] = "asesor"

    else
      redirect_to login_path, alert: "Datos incorrectos"
      return
    end

    redirect_to root_path
  end

  def logout
    session[:rol] = nil
    session[:tiene_tesis] = nil
    redirect_to root_path
  end

end
