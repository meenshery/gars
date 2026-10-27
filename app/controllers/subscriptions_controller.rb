class SubscriptionsController < ApplicationController
  def create
    @subscription = Subscription.new(subscription_params)

    if @subscription.save
      respond_to do |format|
        format.turbo_stream

        format.html do
          redirect_to root_path, notice: "Вы подписаны"
        end
      end
    else
      respond_to do |format|
        format.turbo_stream do
          render :error, status: :unprocessable_entity
        end

        format.html do
          redirect_to root_path, alert: @subscription.errors.first.message
        end
      end
    end
  end

  private

  def subscription_params
    params.expect(
      subscription: [:email, :personal_data_consent, :notifications_consent]
    )
  end
end