class Educator::DashboardsController < ApplicationController
  before_filter :educator_required
  
  def show
    @educator = current_educator
    @profiles = Profile.submitted.ordered
  end
end
