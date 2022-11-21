class CreateFlights < ActiveRecord::Migration[7.0]
  def change
    create_table :flights do |t|
      t.integer :capacity
      t.string :departure
      t.string :arrival
      t.date :date
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
