class UserPolicy < ApplicationPolicy
  def update?
    true
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
