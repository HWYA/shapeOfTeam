class ImportData < ActiveRecord::Migration[5.0]
  def down
    Rake::Task['db:data:load'].invoke
  end
end