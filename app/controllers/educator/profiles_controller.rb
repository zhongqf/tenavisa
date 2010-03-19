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
  
  def accept
    @profile = Profile.find(params[:id])
    if @profile.accept && @profile.save
      flash[:notice] = "The profile was acceptd."
    else
      flash[:error] = "Can not accept this profile."
    end
    redirect_to :back
  end
  
  def deny
    @profile = Profile.find(params[:id])
    if @profile.deny && @profile.save
      flash[:notice] = "The profile was denied."
    else
      flash[:error] = "Can not deny this profile."
    end
    redirect_to :back
  end
  
end
