class Carrera < ApplicationRecord
  has_many :plantel_carreras, dependent: :destroy
  has_many :plantels, through: :plantel_carreras
  validates :nombre,
            presence: true,
            uniqueness: {
              case_sensitive: false,
              message: "ya existe"
            }
end