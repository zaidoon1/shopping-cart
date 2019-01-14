class CreateCartItems < ActiveRecord::Migration[5.1]
  def change
    create_table :cart_items do |t|
      t.integer :item_quantity, default: 1
      t.integer :product_id, :null => false, :references => [:products, :id]
      t.integer :cart_id, :null => false, :references => [:carts, :id]
      t.timestamps
    end
  end
end
