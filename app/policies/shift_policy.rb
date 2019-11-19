class ShiftPolicy < ApplicationPolicy

  def create?
    record.user == user
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
