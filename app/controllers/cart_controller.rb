class CartController < ApplicationController
  include CartHelper
  
  def index
  end

  def add_product
    current_cart.add_product(params)
    redirect_to cart_path
  end

  def add_promocode
    begin
      current_cart.add_promocode(params)
    rescue PromocodeException => e
      current_cart.clear_promocode
      flash[:error] = e.message
    end
    redirect_to cart_path
  end

  def destroy_product
    current_cart.remove_product(params)
    redirect_to cart_path
  end

  def checkout
  end
  
  def proceed_checkout
    order = Order.generate_from current_cart#, current_user
    redirect_to products_path
  end



end
