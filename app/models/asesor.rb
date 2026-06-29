class Asesor < ApplicationRecord
  self.table_name = "asesores"

  belongs_to :tesis,
             class_name: "Nombre",
             foreign_key: "tesis_id",
             optional: true

  validates :nombre,
    presence: { message: "Se requiere agregar Nombre del Asesor" }

  validates :nombre,
    format: {
      with: /\A[a-zA-ZáéíóúÁÉÍÓÚñÑ\s]+\z/,
      message: "Los nombres de los asesores no pueden contener números"
    },
    unless: -> { nombre.blank? }
end