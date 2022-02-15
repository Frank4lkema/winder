class CreateSpots < ActiveRecord::Migration[7.0]
  def change
    create_table :spots do |t|
      t.string :name
      t.float :lon
      t.float :lat

      t.timestamps
    end
  end
end
