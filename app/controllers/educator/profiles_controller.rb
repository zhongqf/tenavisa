require 'prawn/core'
Mime::Type.register 'application/pdf', :pdf

class Educator::ProfilesController < Educatee::ProfilesController
  

  helper_method :edit_profile_path
  
    
  def index
    @profiles = Profile.ordered
  end
  
  def edit
    begin
      @page = Page.find(params[:page])
      @submit_path = educator_profile_path(@profile)
      @elements = @page.elements
    rescue
      redirect_to edit_educator_profile_path(@profile, :page => Page.first) if @page.blank?
    end
  end

  def update    
    @page = Page.find(params[:page_id])
    @submit_path = educator_profile_path
    @elements = @page.elements

    safe = multi_check_safe(params[:profile], params)
    safe = multi_attribute_as_date(safe)
    safe.merge!(:current_page_id => @page.id)
  
    if @profile.update_attributes(safe)
      flash[:notice] = "Profile updated."
      redirect_to educator_profile_path(@profile) + "#page_#{@page.id}"
    else
      flash[:errors] = "There are errors."
      render :action => "edit"
    end
    
  end
  
  def edit_profile_path(profile, options = {})
    edit_educator_profile_path(profile, options)
  end
  
    
  protected
    def role_required
      educator_required
    end
    
    def find_profile
      @profile = Profile.find(params[:id])
    end 
end
