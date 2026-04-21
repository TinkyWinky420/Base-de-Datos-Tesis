class NombresController < ApplicationController
  before_action :set_nombre, only: %i[ show destroy motivo clave confirmar_eliminacion ]
  before_action :bloquear_creacion, only: [:new, :create]

  def index
    @nombres = Nombre.all
  end

  def show
  end

  def new
    @nombre = Nombre.new
    @nombre.integrantes.build
    @nombre.asesores.build
  end

  def create
    if session[:rol] == "alumno" && session[:tiene_tesis]
      redirect_to root_path, alert: "No puedes crear otra tesis"
      return
    end

    @nombre = Nombre.new(nombre_params)

    if @nombre.save

      if session[:rol] == "alumno"
        session[:tiene_tesis] = true
        session[:tesis_id] = @nombre.id
      end

      Historial.create(
        accion: "Creación de tesis",
        descripcion: "Se creó la tesis #{@nombre.titulo} con número #{@nombre.numero_control}"
      )

      redirect_to @nombre, notice: "Tesis creada correctamente."
    else
      puts @nombre.errors.full_messages
      render :new, status: :unprocessable_entity
    end
  end

  def revisar
    if session[:rol] == "alumno" && session[:tesis_id]
      @nombre = Nombre.find_by(id: session[:tesis_id])
    end
  end

  def motivo
  end

  def clave
  end

  def confirmar_eliminacion
    if params[:clave] == "0000"

      Historial.create(
        accion: "Eliminación de tesis",
        descripcion: "Se eliminó la tesis #{@nombre.titulo} con número #{@nombre.numero_control}. Razón: #{params[:motivo]}"
      )

      @nombre.destroy

      session[:tiene_tesis] = false
      session[:tesis_id] = nil

      redirect_to nombres_path, notice: "Tesis eliminada correctamente."
    else
      flash[:alert] = "Clave incorrecta"
      render :clave
    end
  end

  def destroy
    redirect_to motivo_nombre_path(@nombre)
  end

  def buscar
    if params[:numero_control].present?
      numero = params[:numero_control].to_i
      numero_formateado = format("%04d", numero)

      @nombre = Nombre.find_by(numero_control: numero_formateado)
    end
  end

  private

  def bloquear_creacion
    if session[:rol] == "asesor"
      redirect_to root_path, alert: "No tienes permiso"
    end
  end

  def set_nombre
    @nombre = Nombre.find(params[:id])
  end

  def nombre_params
    params.require(:nombre).permit(
      :titulo,
      :descripcion,
      :documento,
      integrantes_attributes: [:id, :nombre, :matricula, :_destroy],
      asesores_attributes: [:id, :nombre, :_destroy]
    )
  end
end