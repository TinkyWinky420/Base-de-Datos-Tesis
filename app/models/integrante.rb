class Integrante < ApplicationRecord
  belongs_to :tesis, class_name: "Nombre", foreign_key: "tesis_id"

  validates :matricula,
    presence: true,
    format: { with: /\A\d+\z/, message: "solo puede contener números" }

  validates :nombre,
    presence: true,
    format: { with: /\A[a-zA-ZáéíóúÁÉÍÓÚñÑ\s]+\z/, message: "no puede contener números" }
end