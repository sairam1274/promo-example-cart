class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :order_items_count
      t.integer :total_value
      t.integer :discount_value
      t.integer :final_value
      t.integer :payment_method
      t.integer :status

      t.timestamps
    end
  end
end
