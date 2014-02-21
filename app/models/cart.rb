class Cart < ActiveRecord::Base
  has_many :cart_items, dependent: :destroy

  has_one :promo_history, :class_name => 'Promo::History'
  has_one :promocode, through: :promo_history
  
  def add_promocode promo
    if promo[:promo_promocode][:code].blank?
      self.clear_promocode
    else
      promo = Promo::Usage.validate code: promo[:promo_promocode][:code], product_list: product_list
      self.update_attributes(promocode: promo) if promo
    end
    recalculate
  end

  def clear_promocode
    self.update_attributes(promocode: nil)
    recalculate
  end

  def add_product params
    add_item(params[:cart_item]) if params[:cart_item].present?
    recalculate
  end

  def remove_product params
    logger.debug "#--- Removing product from the cart"
    destroy_item(params)
    # Validates if the promocode can still in the cart
    if self.promocode
      begin
        self.promocode.is_valid? product_list: product_list
      rescue
        # if it's not valid anymore, removes it
        clear_promocode
      end
    end
    recalculate
  end

  private 

    def recalculate
      logger.debug "#--- Recalculating cart value"
      total = cart_items.includes(:product).map{ |i| i.product.value }.reduce(:+)
      discount = Promo::Usage.discount_for(promocode: self.promocode, product_list: product_list)
      final = total.to_i - discount.to_i 
      self.update_attributes(total_value: total, discount_value: discount, final_value: final)
    end

    def product_list
      cart_items.includes(:product).collect { |item| item.product }
    end

    def validate_quantity item
      1 || item.quantity
    end
    
    def validate_product item
      Product.find(item[:product_id])
    end

    def add_item item
      validate_product item
      item = cart_items.find_or_initialize_by(product_id: item[:product_id], product_type: item[:product_type])
      item.qtd = validate_quantity item
      item.save
    end

    def destroy_item item
      iitem = cart_items.where(product_id: item[:product_id], product_type: item[:product_type]).first
      iitem.destroy if iitem
    end
end
