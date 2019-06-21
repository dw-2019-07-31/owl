class CreateContentEngineImages < ActiveRecord::Migration[5.1]
  def change
    create_table :content_engine_images do |t|
      t.string :code
      t.string :filename
      t.string :extension
      t.binary :imagefile

      t.timestamps
    end
  end
end
