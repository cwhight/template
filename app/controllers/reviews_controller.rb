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
    @user = @shift.user
    @review.shift = @shift
    @review.user = @user
    if @review.save
      redirect_to root_path
    else
      render :new
    end
  end

  def destroy
    @review.destroy
    redirect_to root_path
  end

  private

  def review_params
    params.require(:review).permit(:title, :content, :user_id)
  end

  def set_review
    @review = Review.find(params[:id])
  end
end
