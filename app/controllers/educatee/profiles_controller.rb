class Educatee::ProfilesController < ApplicationController
  before_filter :educatee_required

  def show
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
  end

  def print
  end

end
