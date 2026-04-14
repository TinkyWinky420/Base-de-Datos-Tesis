class Asesor < ApplicationRecord
  self.table_name = "asesores"

  belongs_to :tesis, class_name: "Nombre", foreign_key: "tesis_id"

  validates :nombre,
    presence: true,
    format: { with: /\A[a-zA-ZáéíóúÁÉÍÓÚñÑ\s]+\z/, message: "no puede contener números" }
end