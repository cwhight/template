class OffersController < ApplicationController
  def select
    @user = User.find(params[:id])
    @offer = Offer.new

    authorize @offer
  end

  def show
    @offer = Offer.find(params[:id])
    @request = @offer.request

    authorize @offer
  end

  def new
    @shift = Shift.find(params[:id])
    @user = User.find(params[:user_id])
    @offer = Offer.new

    authorize @offer
  end

  def create
    @offer = Offer.new(offer_params)
    @offer.user = User.find(params[:user_id])
    @offer.shift = Shift.find(params[:id])
    request = Request.new(user: @offer.user, shift: @offer.shift, content: @offer.content)
    @offer.request = request
    authorize @offer
    if @offer.save
      @chat = Chat.new

      if request.save
        @chat.request = request
        @chat.employee = @offer.user
        @chat.employer = @offer.shift.job.user

        if @chat.save
          @message = Message.new
          @message.chat = @chat
          @message.content = @offer.content
          @message.user = @chat.employer
          if @message.save
            sleep 3
            redirect_to dashboard_employer_path(current_user)
          end
        else
          render :new
        end
      else
        render :new
      end
    else

      render :new
    end
  end





  def add_job_to_offer

  end

  private

  def offer_params
    params.require(:offer).permit(:content, :shift_id, :user_id)
  end
end
