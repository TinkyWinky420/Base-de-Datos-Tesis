class Integrante < ApplicationRecord
  belongs_to :tesis, class_name: "Nombre", foreign_key: "tesis_id", optional: true

  validates :matricula,
    format: { with: /\A\d+\z/, message: "solo puede contener números" },
    allow_blank: true

  validates :nombre,
    format: { with: /\A[a-zA-ZáéíóúÁÉÍÓÚñÑ\s]+\z/, message: "no puede contener números" },
    allow_blank: true
end