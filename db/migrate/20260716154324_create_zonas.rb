class CreateZonas < ActiveRecord::Migration[8.1]
  def change
    create_table :zonas do |t|
      t.string :nombre

      t.timestamps
    end
  end
end
