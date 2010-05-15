class Educatee::ProfilesController < ApplicationController
  before_filter :educatee_required

  def show
    @profile = current_educatee.profile
  end

  def edit
    begin
      @profile = current_educatee.profile
      
      @page = Page.find(params[:page])
      @submit_path = educatee_profile_path
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
    
    safe = multi_check_safe(params[:profile], params)
    safe = multi_attribute_as_date(safe)
  
  
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
  
    def multi_check_safe(profile, params)
      safe = {}
      keys = profile.keys
      
      for key in keys
        if profile[key] == "multicheck"
          value = {}
          count = params["#{key}_options_count"].to_i
          for i in 0..count-1
            title_key = "#{key}_option_title_#{i}"
            option_key = "#{key}_option_#{i}"
            additional_key = "#{key}_additional_#{i}"
            
            checked = params.has_key?(option_key) && (params[option_key] == "1")
            has_additional = params.has_key?(additional_key)
            
            value[params[title_key]] = checked ? (has_additional ? params[additional_key] : checked) : checked
            
            safe[key] = value
          end
        else
          safe[key] = profile[key]
        end
      end
      
      safe
    end
  
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
