class AddLatitudeAndLongitudeToPlayers < ActiveRecord::Migration[5.0]
  def change
    add_column :players, :bp_latitude, :decimal
    add_column :players, :bp_longitude, :decimal
  end
end
