class UserPolicy < ApplicationPolicy
  def update?
    record == user
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
