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

    v = order.final_value.to_f/100

    result = Braintree::Transaction.sale(
      :amount => v,
      :credit_card => {
        :number => '4111111111111111',
        :cvv => '111',
        :expiration_month => '11',
        :expiration_year => '2015'
      },
      :options => {
        :submit_for_settlement => true
      }
    )

    binding.pry

    if result.success?
      flash[:notice] = 'pagamento recebido'
    else
      flash[:error] = 'erro ao processar o pagamento'
    end

    redirect_to orders_path
  end

#<Braintree::SuccessfulResult transaction:#
# <Braintree::Transaction 
# id: "fgsr3b", 
# type: "sale", 
# amount: "18.98", 
# status: "submitted_for_settlement", 
# created_at: 2014-02-25 15:12:24 UTC, 
# credit_card_details: #<
#   token: nil, 
#   bin: "411111", 
#   last_4: "1111", 
#   card_type: "Visa", 
#   expiration_date: "11/2015", 
#   cardholder_name: nil, 
#   customer_location: "US", 
#   prepaid: "Unknown", 
#   healthcare: "Unknown", 
#   durbin_regulated: "Unknown", 
#   debit: "Unknown", 
#   commercial: "Unknown", 
#   payroll: "Unknown", 
#   country_of_issuance: "Unknown", 
#   issuing_bank: "Unknown">, 
# customer_details: #<
#   id: nil, 
#   first_name: nil, 
#   last_name: nil, 
#   email: nil, 
#   company: nil, 
#   website: nil, 
#   phone: nil, 
#   fax: nil>, 
# subscription_details: #<Braintree::Transaction::SubscriptionDetails:0x007f86fe3451c0 
#   @billing_period_end_date=nil, 
#   @billing_period_start_date=nil>, 
#   updated_at: 2014-02-25 15:12:24 UTC>>

end





