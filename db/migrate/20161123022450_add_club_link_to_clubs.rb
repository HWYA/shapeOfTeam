class AddClubLinkToClubs < ActiveRecord::Migration[5.0]
  def change
    add_column :clubs, :club_link, :string
  end
end
