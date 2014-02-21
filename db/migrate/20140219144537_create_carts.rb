class CreateCarts < ActiveRecord::Migration
  def change
    create_table :carts do |t|
      t.integer :cart_items_count
      t.integer :total_value
      t.integer :discount_value
      t.integer :final_value

      t.timestamps
    end
  end
end
