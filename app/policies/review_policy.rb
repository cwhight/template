class ReviewPolicy < ApplicationPolicy
  def create?
    true
  end

  def review_dashboard?
    true
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
