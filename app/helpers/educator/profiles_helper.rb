module Educator::ProfilesHelper
  def profile_message_for_educator(profile)
    case profile.aasm_current_state
    when :new
      "This profile is in editing by educatee."
    when :submitted
      "This profile was submitted."
    when :accepted
      "This profile was accepted."
    when :denied
      "This profile was denied."
    end
  end
  
  def profile_valid_actions(profile)
    
    returning(Array.new) do |html|
      
      #if current_educator && profile.can_edit_by_educator
      #  html << link_to("Edit this profile", edit_educator_profile_path(@profile), :class => "button right")
      #end
    
      @profile.aasm_events_for_current_state.each do |event|
      
        case event
          when :freeze
            html << link_to("Freeze", freeze_educator_profile_path(@profile), :method => :post, :class => "button")
          when :unfreeze
            html << link_to("Unfreeze", unfreeze_educator_profile_path(@profile), :method => :post, :class => "button")
          when :archive
            html << link_to("Archive", archive_educator_profile_path(@profile), :method => :post, :class => "button")
        end

      end
    end
  end
end
