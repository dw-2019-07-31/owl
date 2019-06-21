# This migration comes from content_engine (originally 20181108041934)
class CreateContentEngineFiletags < ActiveRecord::Migration[5.1]
  def change
    create_table :content_engine_filetags do |t|
      t.string :filename
      t.string :tag

      t.timestamps
    end
  end
end
