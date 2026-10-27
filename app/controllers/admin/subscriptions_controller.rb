module Admin
  class SubscriptionsController < BaseController
    def index
      authorize! :read, Subscription

      @subscriptions = Subscription.order(created_at: :desc, id: :desc)
    end
  end
end