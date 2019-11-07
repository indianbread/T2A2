class PagesController < ApplicationController
  before_action :authenticate_user!, only: [:admin_dashboard, :user_dashboard]
  before_action :authorise_user, only: [:admin_dashboard]

  def index
  @categories = Category.all
  @recent_products = Product.where(sold: false).last(5)
  end

  def not_found
  end

  def not_authorised
  end

  def admin_dashboard

  end


  def user_dashboard
    @orders = Order.accessible_by(current_ability, :read).sort_by { |k,v| k["created_at"]}.reverse
    @current_products = Product.where(sold: false).accessible_by(current_ability, :update).sort_by { |k,v| k["created_at"]}.reverse
    @previous_products = Product.where(sold: true).accessible_by(current_ability, :update).sort_by { |k,v| k["created_at"]}.reverse

  end
  
  private
  def authorise_user
  if current_user.admin == false
    redirect_to not_authorised_path
  end
end
  
end
