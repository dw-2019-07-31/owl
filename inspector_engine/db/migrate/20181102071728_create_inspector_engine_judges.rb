class CreateInspectorEngineJudges < ActiveRecord::Migration[5.1]
  def change
    create_table :inspector_engine_judges do |t|
      t.string :houhou
      t.string :houhou_eng

      t.timestamps
    end
  end
end
