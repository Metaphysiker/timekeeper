class SelectOptionPolicy < ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def show?
    record.category.account.user == user
  end

  def new?
    !user.blank?
  end

  def edit?
    record.category.account.user == user
  end

  def create?
    record.category.account.user == user
  end

  def update?
    record.category.account.user == user
  end

  def destroy?
    record.category.account.user == user
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
