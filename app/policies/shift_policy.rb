class ShiftPolicy < ApplicationPolicy

  def create?
    record.job.user == user
  end

  def accept_request?
    record.job.user == user
  end

  def show?
    record.user == user || record.job.user == user
  end

  def close_shifts?
    true
  end

  def update?
    record.job.user == user
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
