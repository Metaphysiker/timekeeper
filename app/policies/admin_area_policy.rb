class AdminAreaPolicy < ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def users?
    puts "Company: "
    puts user.inspect
    user.admin?
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
