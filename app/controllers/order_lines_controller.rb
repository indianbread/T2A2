class OrderLinesController < ApplicationController
  def index
    @order_lines = current_order.order_lines
  end

  def new
  end

  def create
    id = params[:id]
    @product = Product.find(id)
    @order = current_order
    order_id = @order.id
    product_id = params[:id]
    @product = OrderLine.new(line_params)
    @order.save
    session[:order_id] = @order.id
    redirect_to order_lines_path
  end

  def show

  end

  def edit
  end

  def destroy
    @order = current_order
    @item = @order.order_lines.find(params[:id])
    @item.destroy
    @order.save
    redirect_to order_lines_path
  end

  private

  def line_params
    params.require(:order_line).permit(:product_id, :order_id)
  end

  
end
