class Product < ActiveRecord::Base
  has_many :promocodes, as: :product

  has_many :cart_item, as: :product
  has_many :order_item, as: :product
  
  has_many :carts, through: :cart_item
  has_many :orders, through: :order_item
end
