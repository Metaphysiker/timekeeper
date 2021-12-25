class ApplicationController < ActionController::Base
  include Pundit

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def after_sign_in_path_for(resource)
    stored_location_for(resource) || my_accounts_accounts_path
  end

  private

  def user_not_authorized
    flash[:alert] = I18n.t("you_are_not_authorized_to_perform_this_action")
    redirect_to(root_path)
  end

end
