class AddNationalityToPlayers < ActiveRecord::Migration[5.0]
  def change
    add_column :players, :nationality, :string
  end
end
