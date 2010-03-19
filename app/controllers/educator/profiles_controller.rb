class Educator::ProfilesController < ApplicationController
  before_filter :educator_required
  
  def index
    @profiles = Profile.all
  end
  
  def show
    @profile = Profile.find(params[:id])
  end

  def edit
  end

  def print
  end

  def update
  end
  
end
