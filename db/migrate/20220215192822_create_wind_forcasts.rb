class CreateWindForcasts < ActiveRecord::Migration[7.0]
  def change
    create_table :wind_forecasts do |t|
      t.integer :hour
      t.integer :wind_speed
      t.integer :wind_gust

      t.timestamps
    end
  end
end
