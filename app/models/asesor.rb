class Asesor < ApplicationRecord
  self.table_name = "asesores"

  belongs_to :tesis, class_name: "Nombre", foreign_key: "tesis_id", optional: true
end