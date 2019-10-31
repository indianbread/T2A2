class PaymentsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [ :webhook ]
  before_action :set_order, only: [:success]
  def success
    order_lines = OrderLine.where("order_id = ?", order_id)

  end

  def webhook
    payment_id = params[:data][:object][:payment_intent]
    #params are sent from stripe through url
    payment = Stripe:PaymentIntent.retrieve ( payment_id )

    order_id = payment.metadata.order_id
    user_id = payment.metadata.user_id

    p "order id = " + order_id
    p "user id = " + user_id
    
    status 200
    
  end
  
private

  def set_order
    order_id = params[:orderId]
    @order = Order.find(order_id)
  end
end