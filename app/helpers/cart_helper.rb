module CartHelper
  def current_cart
    @current_cart ||= Cart.where(session[:cart_id]).first_or_create
    session[:cart_id] = @current_cart.id
    @current_cart
  end
end
