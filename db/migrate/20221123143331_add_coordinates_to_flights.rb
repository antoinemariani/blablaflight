class AddCoordinatesToFlights < ActiveRecord::Migration[7.0]
  def change
    add_column :flights, :latitude, :float
    add_column :flights, :longitude, :float
  end
end
