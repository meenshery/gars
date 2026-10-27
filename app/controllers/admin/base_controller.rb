module Admin
  class BaseController < ApplicationController
    layout "admin"

    before_action :authenticate_user!
    before_action :authorize_admin_access!

    private

    def authorize_admin_access!
      authorize! :access, :admin
    end
  end
end