class Nombre < ApplicationRecord
  has_many :integrantes, foreign_key: "tesis_id"
  has_many :asesores, class_name: "Asesor", foreign_key: "tesis_id"
  has_one_attached :documento
  accepts_nested_attributes_for :integrantes, reject_if: :all_blank
  accepts_nested_attributes_for :asesores, reject_if: :all_blank
  before_create :generar_numero_control
  validates :numero_control, uniqueness: true
  private
  def generar_numero_control
    ultimo = Nombre.maximum(:numero_control).to_i
    siguiente = ultimo + 1
    self.numero_control = format("%04d", siguiente)
  end
end