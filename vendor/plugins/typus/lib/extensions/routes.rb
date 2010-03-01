class ActionController::Routing::RouteSet

  def load_routes_with_typus!
    typus_routes = File.join(File.dirname(__FILE__), *%w[.. .. config typus_routes.rb])
    unless configuration_files.include? typus_routes
      add_configuration_file(typus_routes)
    end
    load_routes_without_typus!
  end

  alias_method_chain :load_routes!, :typus

end
