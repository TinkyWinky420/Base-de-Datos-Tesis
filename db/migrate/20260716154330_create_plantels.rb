class CreatePlantels < ActiveRecord::Migration[8.1]
  def change
    create_table :plantels do |t|
      t.string :nombre
      t.references :zona, null: false, foreign_key: true

      t.timestamps
    end
  end
end
