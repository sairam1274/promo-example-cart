class Order < ActiveRecord::Base
  has_many :order_items, dependent: :destroy

  has_one :promo_history, :class_name => 'Promo::History'
  has_one :promocode, through: :promo_history

  STATUS = {on_hold: 1, canceled: 2, pending_payment: 3, closed: 4}

  def self.generate_from cart#, user
    order = create #({user: user})
    order.copy_items_from cart

    # 1 - get the full value without calculating promocodes
    order.total_value = cart.total_value
    order.discount_value = cart.discount_value
    order.final_value = cart.final_value
    order.promocode = cart.promocode

    order.status = STATUS[:pending_payment]

    # 2 - Updates the promocode status (using it)
    order.promocode.use product_list: order.product_list if order.promocode

    # 3 - Clear the cart
    cart.destroy!

    # 4 - Notify cart generation?
    # remove next line comment to notify when closing order
    #order.notify_order_creation

    order.save
    order
  end

  def copy_items_from cart
    cart.cart_items.each do |item|
      OrderItem.generate_from_cart(self, item)
    end
  end

    def product_list
      order_items.includes(:product).collect { |item| item.product }
    end

end
