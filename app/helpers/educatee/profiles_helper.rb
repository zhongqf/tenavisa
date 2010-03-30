module Educatee::ProfilesHelper
  
  def make_element_form(element, form, profile)
    template_name = "educatee/templates/#{element.kind}"
    
    options = {}
    
    param_script = element.params
    
    if param_script
      param_value = eval(param_script)
      options = param_value[:options] if param_value
    end
    
    render template_name, :element => element, :form => form, :options => options, :profile => profile
  end
  
  def make_form_for(elements, form, profile)
    
    returning(String.new) do |html|
      
      html << content_tag(:h3,"Error message goes here.")
      
      elements.each do |element|
        html << make_element_form(element, form, profile)
      end

    end.html_safe!

  end
  
  def profile_message(profile)
    case profile.aasm_current_state
    when :new
      "If you completed your profile, please " +
      link_to('Submit', submit_educatee_profile_path, :method => :post) +
      " it."
    when :submitted
      "We are confirming your profile. " +
      "Please wait and check your profile status next time."
    when :denied
      "Your profile was denied. Please re-edit it."
    when :accepted
      "Your profile was accepted. We will contact you soon."
    end
    
  end
end
