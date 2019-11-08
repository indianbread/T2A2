class OrdersController < ApplicationController
  load_resource
  skip_load_resource :only => [:new, :create]
  
  def index
    @orders = Order.all.sort_by { |k,v| k["created_at"]}.reverse
  end

  def show
  end

  def edit
 
  end

  def update
    if @order.update(order_params)
      redirect_to @order, notice: 'order successfully updated'
    else
      render :edit
    end
  end

  def new
    @order = Order.new
  end

  def create
    @order = current_user.orders.new(order_params)
    if @order.save
      redirect_to @order, notice: 'order successfully created'
    else
      render :new
    end
  end

  def destroy
    if @order.destroy
      redirect_to orders_path, notice: 'Order successfully deleted'
    else
      render notice: 'Error: Order was unable to be destroyed'
    end

  end

  private

  def order_params
    params.require(:order).permit(:user_id, :total_amount, order_lines_attributes: [:product_id])
   end

end
