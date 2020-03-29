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
    @review.reviewer = current_user
    if @review.save
      if current_user.employer
        @path = "jobs/#{@shift.job.id}"
        respond_to do |format|
          format.html { redirect_to job_path(@shift.job) }
          format.js
        end
      else
        @path = "dashboard"
        respond_to do |format|
          format.html { redirect_to dashboard_path(current_user) }
          format.js
        end

      end
    else
      respond_to do |format|
        format.html { render :new }
        format.js
      end
    end
  end

  def destroy
    @review.destroy
    redirect_to jobs_path
  end

  def review_dashboard
    @review = Review.new
    @reviews = current_user.reviews
    authorize @reviews
  end

  private

  def review_params
    params.require(:review).permit(:title, :content, :user_id, :score)
  end

  def set_review
    @review = Review.find(params[:id])
  end
end
