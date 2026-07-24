class Plantel < ApplicationRecord
  belongs_to :zona
  has_many :plantel_carreras, dependent: :destroy
  has_many :carreras, through: :plantel_carreras
  validates :nombre,
            presence: true,
            uniqueness: {
              scope: :zona_id,
              case_sensitive: false,
              message: "ya existe en esta zona"
            }
end