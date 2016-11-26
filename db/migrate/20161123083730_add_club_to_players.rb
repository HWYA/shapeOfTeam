class AddClubToPlayers < ActiveRecord::Migration[5.0]
  def change
    add_reference :players, :club, foreign_key: true
  end
end
