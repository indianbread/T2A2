# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  #before actions required to accommodate additional parameters from nested fields in user tables
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  def new
    super do
    @user.user_info = UserInfo.new #creating new user info object when a new user is created
    @address = @user.addresses.new # creating new address object when a new user is created
    end
  end

  # POST /resource
  def create
    super
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected

  # def user_info_params
  #   params.require(:user_info).permit( :user_id, :first_name, :surname, :gender )
  # end



  # If you have extra params to permit, append them to the sanitizer.
  
  #extra params required as fields from address and user info table are nested in the user registration form
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [user_info_attributes: [:first_name, :surname, :gender], addresses_attributes: [:street_number,:suburb, :postcode, :state, :country]])
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [user_info_attributes: [:first_name, :surname, :gender], addresses_attributes: [:street_number,:suburb, :postcode, :state, :country]])
  end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource) - take this out if want to go to a page other than root
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
