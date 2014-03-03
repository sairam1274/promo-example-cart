class OrdersController < ApplicationController
  def index
    @orders = Order.all
  end

  def show
    @order = Order.find(params[:id])
    
  end

  def confirm_payment
    @order = Order.find(params[:id])
    @order.confirm_payment
    redirect_to order_path(@order)
  end
  def cancel_payment
    @order = Order.find(params[:id])
    @order.cancel_payment
    redirect_to order_path(@order)
  end
end
