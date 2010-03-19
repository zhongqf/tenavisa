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
  
  def profile_avoid_actions(profile)
    
    returning(Array.new) do |html|    
      @profile.aasm_events_for_current_state.each do |event|
        case event
        when :accept
          html << link_to('Accept', accept_educator_profile_path(@profile), :method => :post)
        when :deny
          html << link_to('Deny', deny_educator_profile_path(@profile), :method => :post)
        end
      end
    end
  end
end
