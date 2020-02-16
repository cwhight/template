class FavouritesController < ApplicationController

  def index
    @favourites = policy_scope(Favourite)
  end

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
    @favourite.destroy
  end

end
