class SubscriptionsController < ApplicationController
  before_action :authenticate_user!

	def create
	  subscription = current_user.subscriptions.first_or_initialize
	  subscription.assign_attributes(endpoint: params['endpoint'], p256dh: params['keys'][:p256dh], auth: params['keys'][:auth])

	  if subscription.save
	    render json: { message: 'Subscription created or updated' }, status: :created
	  else
	    render json: subscription.errors, status: :unprocessable_entity
	  end
	end

  def destroy
    subscription = current_user.subscriptions.find(params[:id])
    subscription.destroy
    head :no_content
  end

  private

  def subscription_params
    params.require(:subscription).permit(:endpoint, keys: [:p256dh, :auth])
  end
end
