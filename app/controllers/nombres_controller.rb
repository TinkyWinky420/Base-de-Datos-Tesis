class NombresController < ApplicationController
  before_action :set_nombre, only: %i[
    show
    documento
    descargar_documento
    destroy
    motivo
    clave
    confirmar_eliminacion
  ]

  before_action :bloquear_creacion, only: [:new, :create]

  def index
    @nombres = Nombre.all

    if params[:carrera].present?
      @nombres = @nombres.where(carrera: params[:carrera])
    end

    if params[:zona].present?
      @nombres = @nombres.where(zona: params[:zona])
    end

    if params[:plantel].present?
      @nombres = @nombres.where(plantel: params[:plantel])
    end
  end

  def show
  end

  def documento
    unless @nombre.documento.attached?
      redirect_to @nombre, alert: "No existe un documento para esta tesis."
      return
    end

    if @nombre.es_pdf?
      render :documento

    elsif @nombre.es_word?
      redirect_to @nombre, notice: "Se detectó un documento Word."

    else
      redirect_to @nombre, alert: "Formato de documento no soportado."
    end
  end

  def descargar_documento
    unless ["asesor", "administrativo"].include?(session[:rol])
      redirect_to documento_nombre_path(@nombre), alert: "No tienes permiso para descargar este documento."
      return
    end

    redirect_to rails_blob_path(
      @nombre.documento,
      disposition: "attachment"
    )
  end

  def new
    @nombre = Nombre.new
    @nombre.integrantes.build
    @nombre.asesores.build
    @zonas = Nombre::ZONAS
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
      @zonas = Nombre::ZONAS
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
  @nombre = nil
  @nombres = []
  case params[:tipo]

  when "numero"
    if params[:numero_control].present?
      numero = params[:numero_control].to_i
      numero_formateado = format("%04d", numero)
      @nombre = Nombre.find_by(
        numero_control: numero_formateado
      )
    end

  when "integrante"
    if params[:nombre].present?
      @nombres = Nombre
                    .joins(:integrantes)
                    .where(
                      integrantes: {
                        nombre: params[:nombre]
                      }
                    )
                    .distinct
    end

  when "asesor"
    if params[:nombre].present?
      @nombres = Nombre
                    .joins(:asesores)
                    .where(
                      asesores: {
                        nombre: params[:nombre]
                      }
                    )
                    .distinct
    end

  when "matricula"
    if params[:matricula].present?
      @nombres = Nombre
                    .joins(:integrantes)
                    .where(
                      integrantes: {
                        matricula: params[:matricula]
                      }
                    )
                    .distinct
    end
  end
end

def sugerencias
  texto = params[:q].to_s.downcase
  tipo = params[:tipo].to_s

  nombres = case tipo

  when "integrante"

    consulta = Integrante
                  .distinct
                  .order(:nombre)

    unless texto.blank?
      consulta = consulta.where(
        "LOWER(nombre) LIKE ?",
        "#{texto}%"
      )
    end

    consulta.pluck(:nombre)

  when "asesor"

    consulta = Asesor
                  .distinct
                  .order(:nombre)

    unless texto.blank?
      consulta = consulta.where(
        "LOWER(nombre) LIKE ?",
        "#{texto}%"
      )
    end

    consulta.pluck(:nombre)

  else

    []

  end

  render json: nombres
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
      :carrera,
      :zona,
      :plantel,
      :documento,
      integrantes_attributes: [:id, :nombre, :matricula, :_destroy],
      asesores_attributes: [:id, :nombre, :_destroy]
    )
  end
end