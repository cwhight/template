class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
    @jobs = Job.all
    @request = Request.new
    @favourite = Favourite.new
  end

  def dashboard
    @user = current_user
    @review = Review.new
  end

  def dashboard_employer
    @employer = current_user
  end
end
