class Educatee::ProfilesController < ApplicationController
  before_filter :educatee_required

  def show
    @profile = current_educatee.profile
  end

  def edit
    begin
      @profile = current_educatee.profile
      logger.debug current_educatee.inspect
      
      @page = Page.find(params[:page])
      @elements = @page.elements
    rescue
      redirect_to edit_educatee_profile_path(:page => Page.first) if @page.blank?
    end
  end

  def update
    @profile = current_educatee.profile
    if @profile.update_attributes(params[:profile])
      flash[:notice] = "Profile updated."
      redirect_to educatee_dashboard_path
    else
      logger.debug @profile.errors.inspect
    end
  end

  def print
  end

end
