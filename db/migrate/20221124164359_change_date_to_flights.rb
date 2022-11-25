class ChangeDateToFlights < ActiveRecord::Migration[7.0]
  def change
    change_column :flights, :date, :datetime
  end
end
