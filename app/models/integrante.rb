class Integrante < ApplicationRecord
  belongs_to :tesis,
             class_name: "Nombre",
             foreign_key: "tesis_id",
             optional: true

  validates :matricula,
    presence: { message: "Se requiere agregar Matrícula" }

  validates :matricula,
    format: {
      with: /\A\d+\z/,
      message: "No puede contener letras"
    },
    unless: -> { matricula.blank? }

  validates :nombre,
    presence: { message: "Se requiere agregar Nombre del Integrante" }

  validates :nombre,
    format: {
      with: /\A[a-zA-ZáéíóúÁÉÍÓÚñÑ\s]+\z/,
      message: "Los nombres de los integrantes no pueden contener numeros"
    },
    unless: -> { nombre.blank? }
end