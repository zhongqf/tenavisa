class Educatee::ProfilesController < ApplicationController
  before_filter :educatee_required

  def show
    @profile = current_educatee.profile
  end

  def edit
    begin
      @profile = current_educatee.profile
      
      @page = Page.find(params[:page])
      @elements = @page.elements
    rescue
      redirect_to edit_educatee_profile_path(:page => Page.first) if @page.blank?
    end
  end
  
  def submit
    @profile = current_educatee.profile
    if @profile.submit && @profile.save
      flash[:notice] = "Your profile was submitted. We will confirm it."
    else
      flash[:error] = "Can not submit your profile."
    end
    redirect_to :back
  end
      

  def update
    @profile = current_educatee.profile
    
    safe = multi_attribute_as_date(params[:profile])

    if @profile.update_attributes(safe)
      flash[:notice] = "Profile updated."
      redirect_to educatee_dashboard_path
    else
      logger.debug @profile.errors.inspect
    end
  end

  def print
  end
  
  private
  
    def multi_attribute_as_date(params)
      
      safe = {}
      keys = params.keys
      
      for key in keys
        if key.include?("(")
          name = key.split("(").first
          
          next if safe.has_key?(name)
          
          year = params["#{name}(1i)"].to_i
          month = params["#{name}(2i)"].to_i
          day = params["#{name}(3i)"].to_i
          
          safe[name] = Date.new(year, month, day)
        else
          safe[key] = params[key]
        end
      end
      safe
    end

end
