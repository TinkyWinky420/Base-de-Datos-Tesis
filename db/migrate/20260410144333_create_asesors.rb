class CreateAsesors < ActiveRecord::Migration[8.1]
  def change
    create_table :asesores do |t|
      t.string :nombre
      t.integer :tesis_id

      t.timestamps
    end
  end
end
