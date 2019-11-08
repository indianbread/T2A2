class ApplicationController < ActionController::Base
  #store action method required to store the url of the previous page, so once user is authenticated they will be returned back to their previous page
  after_action :store_action
  
  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.json { head :forbidden }
      format.html { redirect_to not_authorised_path, :alert => exception.message }
    end
  end

  #get requests from the registrations and sign up pages should not be stored
  def store_action
    return unless request.get? 
    if (request.path != "/users/sign_in" &&
        request.path != "/users/sign_up" &&
        request.path != "/users/password/new" &&
        request.path != "/users/password/edit" &&
        request.path != "/users/confirmation" &&
        request.path != "/users/sign_out" &&
        request.path != "/my/users/sign_in" &&
        request.path != "/my/users/sign_up" &&
        request.path != "/my/users/password/new" &&
        request.path != "/my/users/password/edit" &&
        request.path != "/my/users/confirmation" &&
        request.path != "/my/users/sign_out" &&
        !request.xhr?) # don't store ajax calls
      store_location_for(:user, request.fullpath)
    end
  end

end
