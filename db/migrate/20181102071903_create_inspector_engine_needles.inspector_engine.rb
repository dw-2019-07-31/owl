# This migration comes from inspector_engine (originally 20181102071721)
class CreateInspectorEngineNeedles < ActiveRecord::Migration[5.1]
  def change
    create_table :inspector_engine_needles do |t|
      t.string :houhou
      t.string :houhou_eng
      t.string :basho
      t.string :basho_eng
      t.string :cost

      t.timestamps
    end
  end
end
