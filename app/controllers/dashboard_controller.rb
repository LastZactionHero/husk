class DashboardController < ApplicationController
  authorize_resource class: false
  before_filter :validate_email

  def index
  end

  private

end
