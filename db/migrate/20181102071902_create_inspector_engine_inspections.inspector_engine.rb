# This migration comes from inspector_engine (originally 20181102071709)
class CreateInspectorEngineInspections < ActiveRecord::Migration[5.1]
  def change
    create_table :inspector_engine_inspections do |t|
      t.string :code
      t.string :houhou
      t.string :houhou_eng
      t.string :basho
      t.string :basho_eng
      t.string :cost

      t.timestamps
    end
  end
end
