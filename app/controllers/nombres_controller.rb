class NombresController < ApplicationController
  before_action :set_nombre, only: %i[ show edit update destroy ]

  def index
    @nombres = Nombre.all
  end

  def show
  end

  def new
    @nombre = Nombre.new
  end

  def edit
  end

  def create
    @nombre = Nombre.new(nombre_params)

    if @nombre.save
      redirect_to @nombre, notice: "Tesis creada correctamente."
    else
      puts @nombre.errors.full_messages
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @nombre.update(nombre_params)
      redirect_to @nombre, notice: "Tesis actualizada correctamente."
    else
      puts @nombre.errors.full_messages
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @nombre.destroy
    redirect_to nombres_path, notice: "Tesis eliminada correctamente."
  end

  def buscar
    if params[:numero_control].present?
      @nombre = Nombre.find_by(numero_control: params[:numero_control])
    end
  end

  private

  def set_nombre
    @nombre = Nombre.find(params[:id])
  end

  def nombre_params
    params.require(:nombre).permit(
      :numero_control,
      :titulo,
      :descripcion,
      :documento,
      integrantes_attributes: [:id, :nombre, :matricula, :_destroy],
      asesores_attributes: [:id, :nombre, :_destroy]
    )
  end
end