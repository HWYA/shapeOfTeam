class AddProfileLinkToPlayers < ActiveRecord::Migration[5.0]
  def change
    add_column :players, :profile_link, :string
  end
end
