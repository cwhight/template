class UserPolicy < ApplicationPolicy

  def update?
    record == user
  end

  def order_by_score?
    user.employer
  end

  def filter?
    order_by_score?
  end

  class Scope < Scope
    def resolve
      if user.employer
        scope.all
      else
        raise Pundit::NotAuthorizedError
      end
    end
  end
end
