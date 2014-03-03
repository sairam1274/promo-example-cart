module OrdersHelper
  def show_order_status (status) 
    case status
    when Order::STATUS[:on_hold]
      'a espera'
    when Order::STATUS[:canceled]
      'cancelado'
    when Order::STATUS[:pending_payment]
      'pendente de pagamento'
    when Order::STATUS[:closed]
      'finalizado'
    end
  end
end
