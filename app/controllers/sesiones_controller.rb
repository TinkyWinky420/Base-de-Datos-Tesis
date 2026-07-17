class SesionesController < ApplicationController

  def login
  end

  def procesar_login

    if params[:usuario] == "alumno" && params[:password] == "1234"

      session[:rol] = "alumno"
      redirect_to root_path

    elsif params[:usuario] == "asesor" && params[:password] == "1234"

      session[:rol] = "asesor"
      redirect_to buscar_nombres_path

    elsif params[:usuario] == "administrativo" && params[:password] == "1234"

      session[:rol] = "administrativo"
      redirect_to administrativo_path

    else

      redirect_to login_path,
      alert: "Datos incorrectos"

    end

  end

  def logout
    session[:rol] = nil
    session[:tiene_tesis] = nil
    redirect_to root_path
  end

end
