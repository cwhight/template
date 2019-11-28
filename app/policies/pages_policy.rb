class PagesPolicy < ApplicationPolicy

  def show

  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
