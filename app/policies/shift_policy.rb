class ShiftPolicy < ApplicationPolicy

  def create?
    record.job.user == user
  end

  def accept_request?
    true
  end

  def show?
    record.user == user || record.job.user == user
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
