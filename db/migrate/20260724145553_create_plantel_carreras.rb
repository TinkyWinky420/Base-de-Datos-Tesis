class CreatePlantelCarreras < ActiveRecord::Migration[8.1]
  def change
    create_table :plantel_carreras do |t|
      t.references :plantel, null: false, foreign_key: true
      t.references :carrera, null: false, foreign_key: true

      t.timestamps
    end
  end
end
