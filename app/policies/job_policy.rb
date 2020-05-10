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

  def order_by_pay?
    true
  end

  def filter?
    true
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
