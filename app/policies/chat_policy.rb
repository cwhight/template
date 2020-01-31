class ChatPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    true
  end

  def show?
    record.request.user == user || record.request.shift.job.user == user
  end

  def inbox_show?
    show?
  end

  def inbox?
    true
  end
end
