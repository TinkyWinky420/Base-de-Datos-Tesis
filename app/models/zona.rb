class Zona < ApplicationRecord
  has_many :plantels, dependent: :destroy
  validates :nombre,
            presence: true,
            uniqueness: {
              case_sensitive: false,
              message: "ya existe"
            }
end