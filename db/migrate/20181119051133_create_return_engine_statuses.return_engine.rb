# This migration comes from return_engine (originally 20181119051000)
class CreateReturnEngineStatuses < ActiveRecord::Migration[5.1]
  def change
    create_table :return_engine_statuses do |t|
      t.string :name

      t.timestamps
    end
  end
end
