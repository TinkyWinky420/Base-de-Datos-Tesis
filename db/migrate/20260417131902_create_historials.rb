class CreateHistorials < ActiveRecord::Migration[8.1]
  def change
    create_table :historials do |t|
      t.string :accion
      t.text :descripcion

      t.timestamps
    end
  end
end
