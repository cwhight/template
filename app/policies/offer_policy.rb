class OfferPolicy < ApplicationPolicy

  def show?
    record.user == user
  end

  def new?
    user.employer
  end

  def select?
    new?
  end

  def create?
    new?
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
