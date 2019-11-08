class PaymentsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [ :webhook ]
  # find the order from the params and assign it to an instance variable if payment successful
  before_action :set_order, only: [:success] 

  def success
    # find all order lines associated with the order ID
    order_lines = OrderLine.where("order_id = ?", @order.id)
    order_lines.each do |order|
      # update each product for each order line to indicate that the products have been sold
      order.product.update("sold":true)
    end
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
    #to accommodate for future shopping cart functionality where a new Order object is required to be created when the product page loads
    if @order == nil 
       # get the product ID from the params
        @product = Product.find(params[:productId])
      #create a new Order object and save to database
        @order = Order.create(user_id: current_user.id, total_amount: @product.price) 
      #create a new order line to record the product that was purchased and associate it with the order ID that was created in the previous line
        @order_line = OrderLine.create(order_id: @order.id, product_id: @product.id) 
    else
      # if a new order object has already been created via the shopping cart, use the order ID to get the instance variable of the current order
      order_id = params[:orderId]
      @order = Order.find(order_id)
    end
  end
end