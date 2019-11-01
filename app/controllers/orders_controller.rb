class OrdersController < ApplicationController
  before_create :update_total
  # before_create :update_status

 

  
  def index
  end

  def show
  end

  def edit
  end

  def new
  end

  def destroy
  end

  private

  # def update_status
  #   if self.status == nil?
  #     self.status = "In progress"
  #   end
  # end
  def calculate_total
    self.order_lines.collect { |item| item.product.price }.sum
  end
  
  def update_total
    self.total_amount = calculate_total
  end

  
end
