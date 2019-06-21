class AddIndexToProductsCode < ActiveRecord::Migration[5.1]
  def change
    add_index :products, :code, unique: true
  end
end