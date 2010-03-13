module Educatee::ProfilesHelper
  
  def make_element_form(element, form)
    template_name = "educatee/templates/#{element.kind}"
    render template_name, :element => element, :form => form, :options => {}
  end
  
  def make_form_for(elements, form)
    
    returning(String.new) do |html|
      
      html << content_tag(:h3,"Error message goes here.")
      
      elements.each do |element|
        html << make_element_form(element, form)
      end

    end.html_safe!

  end
end
