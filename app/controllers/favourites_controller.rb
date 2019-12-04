class FavouritesController < ApplicationController

  def create
    @favourite = Favourite.new
    @job = Job.find(params[:job_id])
    @favourite.job = @job
    @favourite.user = current_user
    authorize @favourite
    @favourite.save
  end

  def destroy
    @job = Job.find(params[:job_id])
    @favourite = Favourite.find(params[:id])
    authorize @favourite
    # binding.pry
    @favourite.destroy
  end

end
