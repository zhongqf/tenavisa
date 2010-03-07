module Educatee::ProfilesHelper
  def make_element_form(element)
    content_tag(:p, element.title_cn)
  end
  
  def make_form_for(elements, form)
  end
end
