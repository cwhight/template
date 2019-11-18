class ReviewsController < ApplicationController
  before_action :set_review, only: [:show, :destroy]

  def show
  end

  def new
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    if @review.save
      redirect_to reviews_path
    else
      render :new
    end
  end

  def destroy
    @review.destroy
    redirect_to reviews_path
  end

  private

  def review_params
    params.require(:review).permit(:title, :content, :score)
  end

  def set_review
    @review = Review.find(params[:id])
  end
end
