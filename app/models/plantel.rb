class Plantel < ApplicationRecord
  belongs_to :zona
  validates :nombre,
            presence: true,
            uniqueness: {
              scope: :zona_id,
              case_sensitive: false,
              message: "ya existe en esta zona"
            }
end