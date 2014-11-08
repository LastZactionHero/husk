class HomeController < ApplicationController
  before_filter :redirect_if_logged_in

  layout "landing"

  def index

  end

  private

  def redirect_if_logged_in
    redirect_to dashboard_path if current_user
  end

end
