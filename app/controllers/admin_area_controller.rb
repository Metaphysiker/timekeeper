class AdminAreaController < ApplicationController
  def users
    authorize(:admin_area)
  end

  def pundit_user
    if current_user.admin?
      current_user
    else
      current_company
    end
  end
end
