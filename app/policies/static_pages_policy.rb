class StaticPagesPolicy < ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def welcome?
    true
  end

  def pricing?
    true
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
