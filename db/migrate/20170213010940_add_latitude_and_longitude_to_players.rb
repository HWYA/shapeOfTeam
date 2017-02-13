class AddLatitudeAndLongitudeToPlayers < ActiveRecord::Migration[5.0]
  def change
    add_column :players, :bp_latitude, :number
    add_column :players, :bp_longitude, :number
  end
end
