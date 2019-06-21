# This migration comes from inspector_engine (originally 20181102071725)
class CreateInspectorEnginePackages < ActiveRecord::Migration[5.1]
  def change
    create_table :inspector_engine_packages do |t|
      t.string :package

      t.timestamps
    end
  end
end
