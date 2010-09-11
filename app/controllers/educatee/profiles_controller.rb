require 'prawn'
Mime::Type.register 'application/pdf', :pdf

class Educatee::ProfilesController < ApplicationController
  before_filter :role_required
  before_filter :find_profile, :except => [:index] 
  
  helper_method :edit_profile_path

  def index
  end
  
  def show
    respond_to do |format|
      format.html
      format.pdf do
        
        template = File.join(RAILS_ROOT, "public", SystemConfig.profile_pdf_template_file)

        pdf = Prawn::Document.new(:template => template)
        
        font_zh = File.join(RAILS_ROOT, "simhei.ttf")
        font_ja = File.join(RAILS_ROOT, "ipag.ttf")
        
        Element.all.each do |element|
          script = element.prawn_output_script
          value = @profile.send(element.key)
          eval(script) if script && value
        end

        send_data pdf.render

      end
    end
  end

  def edit
    begin      
      @page = Page.find(params[:page])
      @submit_path = educatee_profile_path
      @elements = @page.elements
    rescue
      redirect_to edit_educatee_profile_path(:page => Page.first) if @page.blank?
    end
  end
  
  def submit
    if @profile.submit && @profile.save
      flash[:notice] = "Your profile was submitted. We will confirm it."
    else
      flash[:error] = "Can not submit your profile."
    end
    redirect_to :back
  end
      

  def update    
    @page = Page.find(params[:page_id])
    @submit_path = educatee_profile_path
    @elements = @page.elements

    safe = multi_check_safe(params[:profile], params)
    safe = multi_attribute_as_date(safe)
    safe.merge!(:current_page_id => @page.id)
  
    if @profile.update_attributes(safe)
      flash[:notice] = "Profile updated."
      redirect_to educatee_dashboard_path
    else
      flash[:errors] = "There are errors."
      render :action => "edit"
    end
    
  end
  
  
  def freeze
    if @profile.freeze && @profile.save
      flash[:notice] = "This Profile was frozen. The educatee can not edit this profile any more."
    else
      flash[:error] = "We can not freeze this profile."
    end
    
    redirect_to :back
  end
  
  def unfreeze
    if @profile.unfreeze && @profile.save
      flash[:notice] = "This Profile was unfrozen. The educatee can edit this profile now."
    else
      flash[:error] = "We can not unfreeze this profile."
    end
    
    redirect_to :back
  end
  
  
  def archive
    if @profile.archive && @profile.save
      flash[:notice] = "This Profile was archived."
    else
      flash[:error] = "We can not archive this profile."
    end
    
    redirect_to :back
  end
  
  def edit_profile_path(profile, options = {})
    edit_educatee_profile_path(profile, options)
  end

  protected
  
    def role_required
      educatee_required
    end
  
    def find_profile
      @profile = current_educatee.profile
    end
  
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
