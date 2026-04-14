class AddNumeroControlToNombres < ActiveRecord::Migration[8.1]
  def change
    add_column :nombres, :numero_control, :string
  end
end
