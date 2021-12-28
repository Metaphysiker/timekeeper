class ApplicationController < ActionController::Base
  include Pundit

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def after_sign_in_path_for(resource)
    if resource.is_a?(User)
      if current_user.accounts.count == 1
        stored_location_for(resource) || account_path(current_user.accounts.first)
      else
        stored_location_for(resource) || my_accounts_accounts_path()
      end
    elsif resource.is_a?(Company)
      stored_location_for(resource) || root_path()
    end


  end

  private

  def user_not_authorized
    flash[:alert] = I18n.t("you_are_not_authorized_to_perform_this_action")
    redirect_to(root_path)
  end

end
