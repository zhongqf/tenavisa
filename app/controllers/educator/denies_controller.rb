class Educator::DeniesController < ApplicationController
  
  before_filter :educator_required

  def show
    @profile = Profile.find(params[:profile_id])
    if @profile.aasm_current_state == :denied
      falsh[:error] = "This profile is denied. You can not deny it again."
      redirect_to :back
    end
    @deny = Deny.new
  end

  def create
    @profile = Profile.find(params[:profile_id])
    @deny = @profile.build_deny(params[:deny].merge(:educator => current_educator))
  
    Profile.transaction do 
      if @deny.save && @profile.deny!
        flash[:notice] = "The profile was denied."
      else
        flash[:error] = "Can not deny this profile."
      end
    end
    
    redirect_to educator_profile_path(@profile)

  end

end
