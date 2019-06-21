class CreateInspectorEngineCriterions < ActiveRecord::Migration[5.1]
  def change
    create_table :inspector_engine_criterions do |t|
      t.string :item_type
      t.string :kijun
      t.string :houhou
      t.string :kijun_eng
      t.string :houhou_eng

      t.timestamps
    end
  end
end
