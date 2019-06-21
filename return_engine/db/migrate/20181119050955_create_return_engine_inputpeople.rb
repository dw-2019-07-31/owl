class CreateReturnEngineInputpeople < ActiveRecord::Migration[5.1]
  def change
    create_table :return_engine_inputpeople do |t|
      t.string :name

      t.timestamps
    end
  end
end
