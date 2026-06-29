class Nombre < ApplicationRecord
  ZONAS = {
  "Zona Rosa" => [
    "Londres"
  ]
}.freeze
  has_many :integrantes, foreign_key: "tesis_id", dependent: :destroy
  has_many :asesores, class_name: "Asesor", foreign_key: "tesis_id", dependent: :destroy

  has_one_attached :documento

  accepts_nested_attributes_for :integrantes, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :asesores, reject_if: :all_blank, allow_destroy: true

  before_create :generar_numero_control

  validates :numero_control, uniqueness: true

  validates :titulo,
    presence: { message: "Se requiere agregar Título" }

  validates :descripcion,
    presence: { message: "Se requiere agregar Descripción" }

  validates :carrera,
    presence: { message: "Se requiere elegir Carrera" }

  validate :documento_obligatorio
  validate :validar_tipo_documento
  validate :validar_integrantes
  validate :validar_asesores

  def es_pdf?
    documento.attached? &&
      documento.content_type == "application/pdf"
  end

  def es_word?
    return false unless documento.attached?

    [
      "application/msword",
      "application/vnd.openxmlformats-officedocument.wordprocessingml.document"
    ].include?(documento.content_type)
  end

  private

  def generar_numero_control
    ultimo = Nombre.unscoped.order(id: :desc).limit(1).pluck(:id).first || 0
    self.numero_control = format("%04d", ultimo + 1)
  end

  def documento_obligatorio
    unless documento.attached?
      errors.add(:documento, "Se requiere agregar Documento")
    end
  end

  def validar_tipo_documento
    return unless documento.attached?

    tipos_permitidos = [
      "application/pdf",
      "application/msword",
      "application/vnd.openxmlformats-officedocument.wordprocessingml.document"
    ]

    unless tipos_permitidos.include?(documento.content_type)
      errors.add(:documento, "No se puede subir documento, formato inválido")
    end
  end

  def validar_integrantes
    if integrantes.reject { |i| i.marked_for_destruction? }.empty?
      errors.add(:integrantes, "Se requiere agregar Integrante")
    end
  end

  def validar_asesores
    if asesores.reject { |a| a.marked_for_destruction? }.empty?
      errors.add(:asesores, "Se requiere agregar Asesor")
    end
  end
end