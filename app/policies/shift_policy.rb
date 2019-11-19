class ShiftPolicy < ApplicationPolicy

  def create?
    record.user == user
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
