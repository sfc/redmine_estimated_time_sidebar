# Hooks to attach to the Redmine base layouts(for right sidebar).
class EstimatedTimeSidebarHook < Redmine::Hook::ViewListener

  def view_layouts_base_sidebar(context = { })
    query = context[:controller].instance_variable_get("@query") rescue nil
    
    if query
      if query.grouped?
        response = query.issue_count_by_group
        %Q(<h3>Estimated time</h3><pre>#{response.inspect}</pre>)
      else
        response = query.issues.size
        %Q(<h3>Estimated time</h3><pre>#{response.inspect} issues</pre>)        
      end 
    else
        %Q(<h3>Estimated time</h3><pre>No query</pre>)      
    end
  end

end