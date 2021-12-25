class CategoryPolicy < ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def show?
    record.account.user == user
  end

  def new?
    !user.blank?
  end

  def edit?
    record.account.user == user
  end

  def create?
    record.account.user == user
  end

  def update?
    record.account.user == user
  end

  def destroy?
    record.account.user == user
  end


  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
