class UsersController < ApplicationController
  has_many :chats

  def edit
    @user = User.find(params[:id])
    authorize @user
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    authorize @user
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
    params.require(:user).permit(:first_name, :surname, :dob, :photo, :summary, :employer)
  end
end
