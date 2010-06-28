class SystemConfig < ActiveRecord::Base
  has_attached_file :profile_pdf_template
  
  def self.profile_pdf_template_file
    @config ||= SystemConfig.first
    @config.profile_pdf_template.url(nil, false) if @config
  end
end