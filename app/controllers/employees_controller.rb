class EmployeesController < ApplicationController
  def index
    @employees = policy_scope(User)
    @employees = User.where(employer: false)
  end
end
