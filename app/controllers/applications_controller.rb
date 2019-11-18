class ApplicationsController < ApplicationController
  before_action :set_application, only: [:show]

  def show
  end

  def new
    @application = Application.new
  end

  def create
    @application = Application.new(application_params)
    @application.user = current_user
    @application.shift = Job.find(params[:shift_id])
    if @application.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def application_params
    params.require(:application).permit(:title, :content, :shift_id)
  end

  def set_application
    @application = Application.find(params[:id])
  end
end
