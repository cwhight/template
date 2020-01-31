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

  def closed_jobs?
    true
  end

  def listed_jobs?
    true
  end

  def favourites?
    true
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
