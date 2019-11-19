class UserPolicy < ApplicationPolicy
  def update?
    true
  end



  # def edit?
  #   true
  # end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
