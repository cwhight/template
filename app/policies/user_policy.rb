class UserPolicy < ApplicationPolicy

  def update?
    record == user
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
