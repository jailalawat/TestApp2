class CreateSkuCombinations < ActiveRecord::Migration[5.2]
  def change
    create_table :sku_combinations do |t|
      t.string :sku_combination
      t.integer :sku_denomination

      t.timestamps
    end
  end
end
