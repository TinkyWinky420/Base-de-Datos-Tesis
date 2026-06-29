class AddCarreraToNombres < ActiveRecord::Migration[8.1]
  def change
    add_column :nombres, :carrera, :string
  end
end
