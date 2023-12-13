class CreateDepartureDates < ActiveRecord::Migration[7.0]
  def change
    create_table :departure_dates do |t|
      t.date :date

      t.timestamps
    end
  end
end
