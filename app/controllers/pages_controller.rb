class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :sign_up]

  def sign_up
  end

  def home
    @jobs = policy_scope(Job).order(created_at: :desc)
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
