class AddressesController < ApplicationController
  before_action :authenticate_user!
  # from cancancan gem to set the address and authorise the current user's permission to view the content
  load_and_authorize_resource
  skip_load_resource :only => [:new, :create]
  def index
    @addresses = current_user.addresses
  end

  def show
  end

  def new
    @address = Address.new
  end

  def create
    @address = current_user.addresses.new(address_params)
    if @address.save
      redirect_to addresses_path, notice: 'Address successfully added'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @address.update(address_params)
      redirect_to addresses_path, notice: 'Address successfully updated'
    else
      render :edit
    end
  end

  def destroy
    if
    @address.destroy
    redirect_to addresses_path, notice:'Address Successfully Removed'
    else
      render notice: 'Error occurred: Address unable to be removed'
    end
  end

  private

  def address_params
    params.require(:address).permit(:user_id, :street_number, :suburb, :postcode, :state, :country)
end
end
