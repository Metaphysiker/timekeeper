class AdminAreaController < ApplicationController
  def users
    authorize :admin_area
  end
end
