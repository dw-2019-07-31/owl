# This migration comes from inspector_engine (originally 20181102071732)
class CreateInspectorEngineConfirms < ActiveRecord::Migration[5.1]
  def change
    create_table :inspector_engine_confirms do |t|
      t.string :houhou
      t.string :houhou_eng

      t.timestamps
    end
  end
end
