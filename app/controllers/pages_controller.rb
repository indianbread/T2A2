class PagesController < ApplicationController
  before_action :authenticate_user!, only: [:admin_dashboard, :user_dashboard]
  before_action :authorise_user, only: [:admin_dashboard]

  def index
  @categories = Category.all
  @recent_products = Product.last(5)
  end

  def not_found
  end

  def not_authorised
  end

  def admin_dashboard

  end


  def user_dashboard
  end
  
  private
  def authorise_user
  if current_user.admin == false
    redirect_to not_authorised_path
  end
end
  
end
