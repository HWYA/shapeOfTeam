class ImportData < ActiveRecord::Migration[5.0]
  def up
    Rake::Task['db:data:load'].invoke
  end
end
