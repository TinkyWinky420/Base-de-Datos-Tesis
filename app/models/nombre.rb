class Nombre < ApplicationRecord
  has_many :integrantes, foreign_key: "tesis_id", dependent: :destroy
  has_many :asesores, class_name: "Asesor", foreign_key: "tesis_id", dependent: :destroy

  has_one_attached :documento

  accepts_nested_attributes_for :integrantes, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :asesores, reject_if: :all_blank, allow_destroy: true

  before_create :generar_numero_control

  validates :numero_control, uniqueness: true
  validates :titulo, presence: true
  validates :descripcion, presence: true

  validate :documento_obligatorio
  validate :validar_tipo_documento
  validate :validar_integrantes
  validate :validar_asesores

  private

  def generar_numero_control
    siguiente = (Nombre.maximum(:id) || 0) + 1
    self.numero_control = format("%04d", siguiente)
  end

  def documento_obligatorio
    unless documento.attached?
      errors.add(:documento, "es obligatorio")
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
      errors.add(:documento, "no se puede subir documento, formato inválido")
    end
  end

  def validar_integrantes
    if integrantes.reject { |i| i.marked_for_destruction? }.empty?
      errors.add(:integrantes, "debe haber al menos un integrante")
    end
  end

  def validar_asesores
    if asesores.reject { |a| a.marked_for_destruction? }.empty?
      errors.add(:asesores, "debe haber al menos un asesor")
    end
  end
end