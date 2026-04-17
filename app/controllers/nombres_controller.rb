class NombresController < ApplicationController
  before_action :set_nombre, only: %i[ show destroy motivo clave confirmar_eliminacion ]

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
    @nombre = Nombre.new(nombre_params)

    if @nombre.save

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
      redirect_to nombres_path, notice: "Tesis eliminada correctamente."
    else
      flash[:alert] = "Clave incorrecta"
      render :clave
    end
  end

  def destroy
    redirect_to motivo_nombre_path(@nombre)
  end

  private

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