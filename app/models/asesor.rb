class Asesor < ApplicationRecord
  self.table_name = "asesores"

  belongs_to :tesis, class_name: "Nombre", foreign_key: "tesis_id", optional: true

  validates :nombre,
    format: { with: /\A[a-zA-ZáéíóúÁÉÍÓÚñÑ\s]+\z/, message: "no puede contener números" },
    allow_blank: true
end