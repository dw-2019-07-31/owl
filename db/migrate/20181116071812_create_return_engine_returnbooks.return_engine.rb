# This migration comes from return_engine (originally 20181116071722)
class CreateReturnEngineReturnbooks < ActiveRecord::Migration[5.1]
  def change
    create_table :return_engine_returnbooks do |t|
      t.string :name

      t.timestamps
    end
  end
end
