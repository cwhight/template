class FavouritePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    user.favourites.all? {|f| f.user == user }
  end

  def create?
    user.favourites.all? {|f| f.job != record.job}

  end

  def destroy?
    record.user == user
  end
end
