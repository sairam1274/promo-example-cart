class OrderItem < ActiveRecord::Base
  belongs_to :order, :counter_cache => true
  belongs_to :product, polymorphic: true

  def self.generate_from_cart(order, item)
    create( order: order, product: item.product, qtd: item.qtd,
      single_value: item.single_value, full_value: item.full_value)
  end

end
