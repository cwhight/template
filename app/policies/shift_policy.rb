class ShiftPolicy < ApplicationPolicy

  def create?
    record.job.user == user
  end

  def accept_request?
    true
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
