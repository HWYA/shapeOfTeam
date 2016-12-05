class CreateDatabaseStructure < ActiveRecord::Migration[5.0]
  # def change
  #   create_table :database_structures do |t|
  #   end
  # end
  def up
    ActiveRecord::Schema.define(version: 20161126045651) do

      # These are extensions that must be enabled in order to support this database
      enable_extension "plpgsql"

      create_table "clubs", force: :cascade do |t|
        t.string   "name"
        t.string   "league_name"
        t.datetime "created_at",  null: false
        t.datetime "updated_at",  null: false
        t.string   "club_link"
      end

      create_table "players", force: :cascade do |t|
        t.string   "name"
        t.string   "position"
        t.string   "place_of_birth"
        t.datetime "created_at",     null: false
        t.datetime "updated_at",     null: false
        t.string   "profile_link"
        t.integer  "club_id"
        t.string   "nationality"
      end

    end
  end
end
