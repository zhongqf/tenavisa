class Educator::DashboardsController < ApplicationController
  before_filter :educator_required
  
  def show
    @profiles = Profile.find_all_by_status('new')
  end
end
