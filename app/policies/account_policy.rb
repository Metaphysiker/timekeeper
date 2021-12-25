class AccountPolicy < ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def my_accounts?
    !user.blank?
  end

  def manage_categories?
    record.user == user
  end

  def index?
    user.admin?
  end

  def show?
    record.user == user
  end

  def new?
    !user.blank?
  end

  def edit?
    record.user == user
  end

  def create?
    record.user == user
  end

  def update?
    record.user == user
  end

  def destroy?
    record.user == user
  end

  def data_overview?
    record.user == user
  end

  def area_chart_data?
    record.user == user
  end

  def donut_chart_data?
    record.user == user
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
