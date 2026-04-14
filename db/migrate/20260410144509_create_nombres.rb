class CreateNombres < ActiveRecord::Migration[8.1]
  def change
    create_table :nombres do |t|
      t.string :titulo
      t.text :descripcion

      t.timestamps
    end
  end
end
