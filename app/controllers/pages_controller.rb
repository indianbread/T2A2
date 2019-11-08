class PagesController < ApplicationController
  # users must sign in to access dashboard
  before_action :authenticate_user!, only: [:admin_dashboard, :user_dashboard]
  # check that user is admin, if not, redirect to the not authorised page
  before_action :authorise_user, only: [:admin_dashboard]

  def index
    # only display the last 5 products that have not been sold
    @recent_products = Product.where(sold: false).last(5)
  end

  def not_found
  end

  def not_authorised
  end

  def admin_dashboard
  end


  def user_dashboard
    # display products that have not been sold and that the user has read access to, i.e. their own product listing
    @current_products = Product.where(sold: false).accessible_by(current_ability, :update).sort_by { |k,v| k["created_at"]}.reverse
    # display products that have been sold and that the user has read access to, i.e. their own product listing
    @previous_products = Product.where(sold: true).accessible_by(current_ability, :update).sort_by { |k,v| k["created_at"]}.reverse
  end
  
  private

  def authorise_user
    if current_user.admin == false
      redirect_to not_authorised_path
    end
  end
  
end
