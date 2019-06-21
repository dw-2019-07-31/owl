class CreateInspectorEnginePackages < ActiveRecord::Migration[5.1]
  def change
    create_table :inspector_engine_packages do |t|
      t.string :package

      t.timestamps
    end
  end
end
