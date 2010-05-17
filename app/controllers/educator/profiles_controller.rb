require 'prawn/core'
Mime::Type.register 'application/pdf', :pdf

class Educator::ProfilesController < ApplicationController
  before_filter :educator_required
  
  def index
    @profiles = Profile.all
  end
  
  def show
    @profile = Profile.find(params[:id])

    respond_to do |format|
      format.html
      format.pdf do
        
        template = File.join(RAILS_ROOT, "public", SystemConfig.profile_pdf_template_file)

        pdf = Prawn::Document.new(:template => template)
        
        font_zh = File.join(RAILS_ROOT, "simhei.ttf")
        font_ja = File.join(RAILS_ROOT, "ipam.ttf")
        
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
      @profile = Profile.find(params[:id])      
      @page = Page.find(params[:page])
      @submit_path = educator_profile_path(@profile)
      @elements = @page.elements
    rescue
      redirect_to edit_educator_profile_path(@profile, :page => Page.first) if @page.blank?
    end
  end

  def print
    @profile = Profile.find(params[:id])
    
    template = File.join(RAILS_ROOT, "public", SystemConfig.profile_pdf_template_file)
    outputfile = "profile_#{@profile.id}"
    
    pdf = Prawn::Document.new(:template => template)
    pdf.fill_color "ff0000"
    pdf.text "Baby, comes to me"
    pdf.render_file outputfile
    send_data pdf.render
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
