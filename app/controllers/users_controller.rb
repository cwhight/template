class UsersController < ApplicationController

  def index
    @employees = policy_scope(User)
    @employees = User.where(employer: false)

  end

  def edit
    @user = User.find(params[:id])
    authorize @user
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    authorize @user
    skill_ids = params[:user][:skill_ids].drop(1)
    @skills = skill_ids.map do |element|
      Skill.find(element)
    end
    @user.skills = @skills
    if @user.save
      if @user.employer
        redirect_to dashboard_employer_path(@user)
      else
        redirect_to dashboard_path(@user)
      end
    else
      render :edit
    end
  end

  def stripe_sign_up
    request.format = :json

    state = params[:state]
    if !state_matches?(state)
      status 403
      return {error: 'Incorrect state parameter: ' + state}.to_json
    end

    # Send the authorization code to Stripe's API.
    code = params[:code]
    begin
      response = Stripe::OAuth.token({
        grant_type: 'authorization_code',
        code: code,
      })
    rescue Stripe::OAuth::InvalidGrantError
      status 400
      return {error: 'Invalid authorization code: ' + code}.to_json
    rescue Stripe::StripeError
      status 500
      return {error: 'An unknown error occurred.'}.to_json
    end

    connected_account_id = response.stripe_user_id
    save_account_id(connected_account_id)

    # Render some HTML or redirect to a different page.
    status 200
    {success: true}.to_json
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :surname, :dob, :photo, :summary, :employer, :skills)
  end

  def state_matches?(state_parameter)
  # Load the same state value that you randomly generated for your OAuth link.
    saved_state = '{{ STATE }}'

    saved_state == state_parameter
  end

  def save_account_id(id)
    # Save the connected account ID from the response to your database.
    puts 'Connected account ID: ' + id
  end
end
