class CreateOrderItems < ActiveRecord::Migration
  def change
    create_table :order_items do |t|
      t.references :order, index: true
      t.references :product, polymorphic: true, index: true

      t.integer :qtd
      t.integer :single_value
      t.integer :full_value

      t.timestamps
    end
  end
end
