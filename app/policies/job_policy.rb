class JobPolicy < ApplicationPolicy

  def show?
    true
  end

  def create?
    true
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
