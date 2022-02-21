class AddSpotIdtoSpot < ActiveRecord::Migration[7.0]
  def change
    add_column :spots, :spot_id, :integer
  end
end
