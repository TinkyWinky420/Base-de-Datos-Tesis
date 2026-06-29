class AddZonaYPlantelToNombres < ActiveRecord::Migration[8.1]
  def change
    add_column :nombres, :zona, :string
    add_column :nombres, :plantel, :string
  end
end
