class OrderLinesController < ApplicationController
  #delete this if not required
  load_and_authorize_resource
  skip_load_resource :only => [:new, :create]

  def index
    @order_lines = OrderLine.where(:order_id: order_id)
  end

  def new
  end

  def create
    @order_line = current_user.order_lines.new(order_line_params)
    # @user_detail.user_id = current_user.id

    if @order_line.save
      redirect_to @order_line
    else
      render :new
    end
  end

  def show

  end

  def edit
  end

  def destroy
    if @order_line.destroy
      redirect_to orders_path
    else
      render notice: 'item could not be removed from order'
    end
  end

  private

  def order_line_params
    params.require(:order_line).permit(:product_id, :order_id)
  end

  def set_order
    order_id = params[:id]
  end
end
