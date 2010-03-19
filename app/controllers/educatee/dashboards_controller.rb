class Educatee::DashboardsController < ApplicationController
  before_filter :educatee_required

  def show
    @profile = current_educatee.profile
  end

end
