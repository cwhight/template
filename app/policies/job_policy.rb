class JobPolicy < ApplicationPolicy

  def show?
    record.user == user
  end

  def create?
    user.employer
  end

  def update?
    record.user == user
  end

  def close?
    record.user == user
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
