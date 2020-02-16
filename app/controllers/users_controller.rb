class UsersController < ApplicationController

  def index
    @employees = policy_scope(User)
    @employees = User.where(employer: false)

  end

  def edit
    @user = User.find(params[:id])
    authorize @user
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    authorize @user
    skill_ids = params[:user][:skill_ids].drop(1)
    @skills = skill_ids.map do |element|
      Skill.find(element)
    end
    @user.skills = @skills
    if @user.save
      if @user.employer
        redirect_to dashboard_employer_path(@user)
      else
        redirect_to dashboard_path(@user)
      end
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :surname, :dob, :photo, :summary, :employer, :skills)
  end
end
