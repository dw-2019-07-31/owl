class AddKanaToProducts < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :kana, :string
  end
end
