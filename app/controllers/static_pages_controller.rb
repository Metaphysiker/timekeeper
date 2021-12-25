class StaticPagesController < ApplicationController
  after_action :verify_authorized

  def welcome
    authorize :static_pages
    @page_title       = I18n.t("welcome")
    @page_description = I18n.t("welcome_description")
    @page_keywords    = I18n.t("welcome_keywords")
  end

  def pricing
    authorize :static_pages
    @page_title       = I18n.t("pricing")
    @page_description = I18n.t("pricing_description")
    @page_keywords    = I18n.t("pricing_keywords")
  end
end
