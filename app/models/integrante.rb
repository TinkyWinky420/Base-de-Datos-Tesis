class Integrante < ApplicationRecord
  belongs_to :tesis, class_name: "Nombre", foreign_key: "tesis_id", optional: true
end