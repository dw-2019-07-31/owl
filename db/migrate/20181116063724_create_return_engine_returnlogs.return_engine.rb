# This migration comes from return_engine (originally 20181116063507)
class CreateReturnEngineReturnlogs < ActiveRecord::Migration[5.1]
  def change
    create_table :return_engine_returnlogs do |t|
      t.string :arrived_date
      t.string :delivery_trader
      t.string :owner_code
      t.string :owner_name
      t.string :cutoff_date
      t.string :sales_person
      t.string :inquiry_no
      t.string :boxes_count
      t.string :peace_count
      t.string :returned_date
      t.string :input_person
      t.string :note
      t.string :return_book
      t.string :status

      t.timestamps
    end
  end
end
