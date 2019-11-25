class ReviewsController < ApplicationController
  before_action :set_review, only: [:show, :destroy]

  def show
  end

  def new
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    authorize @review
    @shift = Shift.find(params[:shift_id])
    @review.shift = @shift
    if current_user.employer
      @user = @shift.user
    else
      @user = @shift.job.user
    end

    @review.user = @user

    if @review.save
      if current_user.employer
        redirect_to job_path(@shift.job)
      else
        redirect_to dashboard_path(current_user)
      end
    else
      render :new
    end
  end

  def destroy
    @review.destroy
    redirect_to jobs_path
  end

  private

  def review_params
    params.require(:review).permit(:title, :content, :user_id, :score)
  end

  def set_review
    @review = Review.find(params[:id])
  end
end
